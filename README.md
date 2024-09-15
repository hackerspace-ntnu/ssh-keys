# ssh-keys

Public SSH keys for the Hackerspace servers

The `authorized_keys` files on Hackerspace servers are automatically populated with the SSH keys in this repository on a per server basis.

## Adding a new key

Adding a new key will grant the key owner server access. Only add a key to the servers you need access to.

For services like deployment etc. it is important to add a new key specific for the service instead of reusing an existing one.

1. Generate a new SSH key using `ssh-keygen`.

```bash
ssh-keygen -t ed25519 -C "your@email.com"
```

- Use `ed25519` as the key type. It is more modern than `rsa`.
- For the comment, include a way to contact you, phone number or email (This is not necessary for keys used for services, then a comment with the service name is enough).

2. Create a new branch, commit and push your **public** key file in the appropriate directory for the server inside the `keys` directory.

Typically, a public key file looks something like the following:

```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINvlUIQHvVRV0D+BY51Fzf2Q/r0wxMA9JPAPFk1iQTQv hackerspace-dev@idi.ntnu.no
```

If you see the word `PRIVATE` anywhere in the file(s) you are commiting, **stop immediately**. Private keys are like passwords and should be treated as highly confidential.

3. Open a pull request and have the DevOps leadership review the addition

After your key is merged in, you should get SSH access to the respective server within a few minutes.

> [!NOTE]
> If you are new to SSH, there is a private guide in the DevOps server documentation on GitHub.

## Removing a key

SSH keys should be removed from the repository as soon as they are no longer in use. This _especially_ applies to retired DevOps members.

So when a member leaves the Hackerspace, their keys should be removed.

1. Create a new branch, commit and push the removal of the appropriate key file
2. Open a pull request and wait for review
3. Merge the key removal
