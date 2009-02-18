import re

def collabora_nametrans(fn):
    name = 'collabora.%s' % fn
    name = re.sub(r'^collabora\.INBOX', 'collabora', name)
    name = re.sub(r'^collabora\.Lists\.', 'lists.', name)
    name = re.sub(r'^collabora\.lists\.', 'lists.', name)
    return name


def jonnylamb_nametrans(fn):
    name = fn
    name = re.sub(r'^INBOX', 'inbox', name)
    name = re.sub(r'^Drafts', 'drafts', name)
    name = re.sub(r'^Sent', 'sent', name)
    name = re.sub(r'^Spam', 'spam', name)
    name = re.sub(r'^Trash', 'trash', name)
    return name

def durham_nametrans(fn):
    name = 'durham.%s' % fn
    name = re.sub(r'^durham\.INBOX', 'durham', name)
    name = re.sub(r'^durham\.Lists\.', 'lists.', name)
    return name
