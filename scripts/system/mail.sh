#################
# File with commands that make it easier to work with system mails
#################

#MODULE_PREFIX=m

# TODO: mail command is an utter load of crap. We'll have to process mail file directly using:
# grep -E '^Subject: ' /var/mail/kshitiz -n

# Returns list of mails that are unread
m_unread() {
	:
}

# Returns mails recently received. Recently is defined by following variable in number of hours
RECENT_LIMIT=1
recent_mails() {
	:
}

# Selects all mails that match given conditions
# Some sample conditions: from a particular sender, containing given text in subject line, containing given text in body, received between given dates
select_mails() {
	:
}

# Delete given list of mails. Can be passed output of select_mails
delete_mails() {
	:
}

