#!/usr/bin/env python
import sys, re
from subprocess import check_output

commit_msg_filepath = sys.argv[1]

try:
    branch = check_output(['git', 'symbolic-ref', '--short', 'HEAD']).decode('utf-8').strip()
    # branch = check_output(['git', 'rev-parse', ' --abbrev-ref', 'HEAD']).decode('utf-8').strip()
    print('\n hook: '+branch+'\n')
    with open(commit_msg_filepath, 'r+') as fh:
        # if(branch != 'HEAD'):
        issueRegex = r'(\w+-\d+)' # letter-number, e.g. ISSUE-392
        autosquashRegex = r'(^fixup\!.+|^squash\!.+)' # for autosquash
        commit_msg = fh.read()
        if re.match(autosquashRegex,commit_msg):
            print('\nautosquash commit detected, prepare-commit-msg did not run\n')
        elif re.match(issueRegex, branch):
            issue = re.match(issueRegex, branch).group(1)
            fh.seek(0, 0)
            fh.write('[%s] %s' % (issue, commit_msg))
except:
    print('\nprepare-commit-msg did not run\n')
