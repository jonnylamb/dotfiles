import re

filter_lists = False

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

def collabora_folderfilter(fn):
    if fn in ['Spam', 'Drafts', 'Trash', 'Queue', 'Lists', 'Sent']:
        return False
    if filter_lists and (fn.startswith('lists.') or fn.startswith('lists.')):
        return False
    return True

def jonnylamb_folderfilter(fn):
    if fn in ['spam', 'Queue', 'Lists', 'lists', 'oldSpam', 'oldnewspam']:
        return False
    if filter_lists and (fn.startswith('lists.') or fn.startswith('Lists.')):
        return False
    return True
