###############
# File that makes it easier to work with cron jobs
###############

# Schedules a given shell script as a cron job
# Allows scheduling using keywords instead of cron expressions
# Example keywords: daily 5pm, saturday 5pm, hourly 3min, every_minute
# Does not provide keywords for every possible cron expression but only common used ones. For greater control use cron expressions.
# The script is saved in $BASH_HOME/data/cron/jobs/ with name - [numberic-id]-filename.sh
# Log output is saved in $BASH_HOME/data/cron/logs/[numeric-id]/date.sh
schedule() {
	:
}

