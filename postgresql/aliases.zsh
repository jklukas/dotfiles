alias redshift-update="ssh bastion-us-west-1a.dmz \"find . -iname '*.env'\" | xargs -I{} bash -c \"ssh bastion-us-west-1a.dmz cat {} | gpg -ear klukas@simple.com > ~/.secrets/{}.gpg\""
alias redshift-dev="envcrypt ~/.secrets/redshift-dev-analytics.env.gpg psql"
alias redshift-prod="envcrypt ~/.secrets/redshift-prod-analytics.env.gpg psql"
