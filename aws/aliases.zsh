alias pyaws='envcrypt ~/.secrets/aws.gpg ~/Code/aws-ipython/venv/bin/ipython --no-confirm-exit --no-banner -i ~/Code/aws-ipython/aws/main.py'
alias aws='withenv aws.gpg -- aws-mfa /usr/local/bin/aws'
