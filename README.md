# ssh-keys
Public SSH keys for DevOps members

The `authorized_keys` files on Hackerspace servers are automatically populated with the SSH keys in this repository.

## Adding a new key

Adding a new key will grant the key owner server access.

1. Generate a new SSH key using your generator of choice (typically PuTTYgen or ssh-keygen)
   - If using PuTTYgen, ensure you export the keyfiles with the OpenSSH format
2. Create a new branch, commit and push your **public** key file

Typically, a public key file looks something like the following:
```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCuS3I1pwSSUtT6NqeKxa33vwXHQy0f7xlyZHq5dlB3UYJNamDR0KEs/fhxjyCJ8XLf7nJNvojJ5qAtxEJjpnVonM6ehHi3juHxgMJOGIZHcWJ72BpjdcWZk0LuOx0x1qTdHFlU+6aTl27dSgVB+2QQESwQTtVgbIGiNcdt3ES9+Yhc8Sk0PrZ2TW5cTdZJlv/kb/cKgFIk8UQqu5h7TJHyq+L6kbEZrlhB2YmJ1ZICaN2YYsHKvtX5ibkJB4RpAOwOiUHVlDzrlBzjdIKxseCt5oEIANObmdk9YOXfMeAQNJDa3Hx3j5yXuMaJCPFqdwxfzeSOJ+OFGSS5q9FG1Dr/
```
If you see the word `PRIVATE` anywhere in the file(s) you are commiting, **stop immediately**. Private keys are like passwords should be treated as highly confidential.

1. Open a pull request and have someone review the addition of your key
2. Merge your key in

After your key is merged in, you should get SSH access to the Hackerspace servers soon(tm).

## Removing a key

SSH keys should be removed from the repository as soon as they are no longer in use. This *especially* applies to retired DevOps members.

1. Create a new branch, commit and push the removal of the appropriate key file
2. Open a pull request and have someone review the removal
3. Merge the key removal
