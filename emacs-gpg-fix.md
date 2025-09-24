# Fixing GPG Passphrase Prompt Issues in Emacs (Keystrokes "Leaking")

## Problem
When Emacs opens GPG-encrypted files, the external `pinentry` program (used by `gpg-agent` to ask for the passphrase) can lose input focus.  
This causes keystrokes to "leak" into the terminal or window behind Emacs instead of the password prompt.

## Solution: Use Emacs Minibuffer for Passphrases

### 1. Configure GPG Agent
Edit `~/.gnupg/gpg-agent.conf` and add:
```
allow-loopback-pinentry
```

Restart the GPG agent:
```bash
gpgconf --kill gpg-agent
```

### 2. Configure Emacs
Add the following to your Emacs config (`~/.emacs` or `~/.emacs.d/init.el`):
```elisp
(setq epa-pinentry-mode 'loopback)
```

## Result
Now Emacs will prompt for GPG passphrases directly in its minibuffer,  
avoiding the focus/input problems caused by external `pinentry`.
