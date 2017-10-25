# vvv-wordpress-default

## Add to host file
install [Vagrant Hosts Updater plugin](https://github.com/cogitatio/vagrant-hostsupdater) or
paste the below
`http://vvv.otestsite.dev/` to host file
```bash
 grep -q '^192.168.50.4' /etc/hosts || sudo sh -c 'echo "192.168.50.4 vvv.otestsite.dev site1.vvv.otestsite.dev site2.vvv.otestsite.dev" >> /etc/hosts'

```
