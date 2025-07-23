local menu = {
  -- MENU
  default = {
    items = {
      -- Jump to another menu
      -- { "Editor", "Telescope menu editor" },
    },
  },
  slimv = {
    items = {
      { "Find definition",                     ':call SlimvFindDefinitions()' },
      { "Eval - Defun",                        ':call SlimvEvalDefun()' },
      { "Eval - Current",                      ':call SlimvEvalExp()' },
      { "Eval - Region",                       ':call SlimvEvalRegion()' },
      { "Eval - Buffer",                       ':call SlimvEvalBuffer()' },
      { "Eval - Interactive",                  ':call SlimvInteractiveEval()' },
      { "Eval - Undefine Func",                ':call SlimvUndefineFunction()' },

      { "Debug - Macroexpand-1",               ':call SlimvMacroexpand()' },
      { "Debug - Macroexpand-All",             ':call SlimvMacroexpandAll()' },
      { "Debug - Toggle-Trace...",             ':call SlimvTrace()' },
      { "Debug - Untrace-All",                 ':call SlimvUntrace()' },
      { "Debug - Set-Breakpoint",              ':call SlimvBreak()' },
      { "Debug - Break-on-Exception",          ':call SlimvBreakOnException()' },
      { "Debug - Disassemble",                 ':call SlimvDisassemble()' },
      { "Debug - Abort",                       ':call SlimvDebugAbort()' },
      { "Debug - Quit-to-Toplevel",            ':call SlimvDebugQuit()' },
      { "Debug - Continue",                    ':call SlimvDebugContinue()' },
      { "Debug - Restart-Frame",               ':call SlimvDebugRestartFrame()' },
      { "Debug - Step-Into",                   ':call SlimvDebugStepInto()' },
      { "Debug - Step-Next",                   ':call SlimvDebugStepNext()' },
      { "Debug - Step-Out",                    ':call SlimvDebugStepOut()' },
      { "Debug - List-Threads",                ':call SlimvListThreads()' },
      { "Debug - Kill-Thread...",              ':call SlimvKillThread()' },
      { "Debug - Debug-Thread...",             ':call SlimvDebugThread()' },

      { "Compile - Defun",                     ':call SlimvCompileDefun()' },
      { "Compile - Load-File",                 ':call SlimvCompileLoadFile()' },
      { "Compile - File",                      ':call SlimvCompileFile()' },
      { "Compile - Region",                    ':call SlimvCompileRegion()' },

      { "Xref - Who-Calls ",                   ':call SlimvXrefCalls()' },
      { "Xref - Who-References ",              ':call SlimvXrefReferences()' },
      { "Xref - Who-Sets ",                    ':call SlimvXrefSets()' },
      { "Xref - Who-Binds ",                   ':call SlimvXrefBinds()' },
      { "Xref - Who-Macroexpands ",            ':call SlimvXrefMacroexpands()' },
      { "Xref - Who-Specializes",              ':call SlimvXrefSpecializes()' },
      { "Xref - List-Callers",                 ':call SlimvXrefCallers()' },
      { "Xref - List-Callees",                 ':call SlimvXrefCallees()' },

      { 'Documentation - Describe-Symbol',     ':call SlimvDescribeSymbol()' },
      { 'Documentation - Apropos',             ':call SlimvApropos()' },
      { 'Documentation - Hyperspec',           ':call SlimvHyperspec()' },
      { 'Documentation - Generate-Tags',       ':call SlimvGenerateTags()' },

      { 'Repl - Connect-Server',               ':call SlimvConnectServer()' },
      { 'Repl - Interrupt-Lisp-Process',       ':call SlimvInterrupt()' },
      { 'Repl - Clear-REPL',                   ':call SlimvClearReplBuffer()' },
      { 'Repl - Quit-REPL',                    ':call SlimvQuitRepl()' },

      { 'Profiling - Toggle-Profile...',       ':call SlimvProfile()' },
      { 'Profiling - Profile-By-Substring...', ':call SlimvProfileSubstring()' },
      { 'Profiling - Unprofile-All',           ':call SlimvUnprofileAll()' },
      { 'Profiling - Show-Profiled',           ':call SlimvShowProfiled()' },
      { 'Profiling - Profile-Report',          ':call SlimvProfileReport()' },
      { 'Profiling - Profile-Reset',           ':call SlimvProfileReset()' },

      { "REPL! - Send-Input",                  ':call SlimvSendCommand(0)' },
      { "REPL! - Close-Send-Input",            ':call SlimvSendCommand(1)' },
      { "REPL! - Set-Package",                 ':call SlimvSetPackage()' },
      { "REPL! - Interrupt-Lisp-Process",      'call SlimvInterrupt()' },
      { "REPL! - Previous-Input",              ':call SlimvPreviousCommand()' },
      { "REPL! - Next-Input",                  ':call SlimvNextCommand()' },
      { "REPL! - Clear-REPL",                  ':call SlimvClearReplBuffer()' },

    },
  },
}
return menu
