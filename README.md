# vvv-wordpress-default

## Add to host file
install [Vagrant Hosts Updater plugin](https://github.com/cogitatio/vagrant-hostsupdater) or
paste the below
`http://vvv.otestsite.dev/` to host file
```bash
 grep -q '^192.168.50.4' /etc/hosts || sudo sh -c 'echo "192.168.50.4 vvv.otestsite.dev site1.vvv.otestmultisite.dev site2.vvv.otestmultisite.dev site3.vvv.otestmultisite.dev vvv.otestmultisite.dev" >> /etc/hosts'

```
