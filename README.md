# vvv-wordpress-default

## Add to host file
install [Vagrant Hosts Updater plugin](https://github.com/cogitatio/vagrant-hostsupdater) or
paste the below
`http://vvv.otestsite.dev/` to host file
```bash
 grep -q '^192.168.50.4' /etc/hosts || sudo sh -c 'echo "192.168.50.4 vvv.dev local.wordpress.dev src.wordpress-develop.dev build.wordpress-develop.dev vvv.otestsite.dev site1.otestmultisite.dev site2.otestmultisite.dev site3.otestmultisite.dev otestmultisite.dev" >> /etc/hosts'

```
