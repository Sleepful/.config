;; renaming functionality BIG TIME
(defun tide-rename-file-elisp (projDir old new)
  (with-current-buffer (tide-get-file-buffer (concat projDir old))
;   (tide-restart-server)
   (let* (
         (name (buffer-name))
         (old (concat projDir old))
         (new (concat projDir new))
         (response (tide-command:getEditsForFileRename old new)))
    (tide-on-response-success response (:min-version "2.9")
      (tide-do-rename-file old new (plist-get response :body))
      (message "Renamed '%s' to '%s'." (file-name-nondirectory old) (file-name-nondirectory new)))
    )))

(defun tide-rename-files-with-lists (projDir oldNames newNames)
  (cl-mapcar 'tide-rename-file-elisp
             (make-list (length oldNames) projDir)
             oldNames
             newNames)
  )

;; example
(tide-rename-file-elisp
"/Users/jose/Code/connectors/"
"/services/forecasting/sequentialGrowth.test.ts"
"/services/cashForecast/sequentialGrowth.test.ts")

;; example
(setq oldList '(
"src/server/routes/api/forecasting/forecast.ts"
"src/server/routes/api/forecasting/index.ts"))
(setq newList '(
"src/server/routes/api/cashForecast/forecast.ts"
"src/server/routes/api/cashForecast/index.ts"))
(tide-rename-files-with-lists
 "/Users/jose/Code/connectors/"
 oldList
 newList
)

;; recommended
(setq tide-sync-request-timeout 30)
