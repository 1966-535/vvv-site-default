# Contributing 

## Dev Setup

The site was designed to get up and running quickly via [varying-vagrant-vagrants][2].

So to get started, follow the [First Vagrant Up][3] instructions, including:

```bash
git clone git@github.com:Varying-Vagrant-Vagrants/VVV.git vvv
cd vvv
vagrant up --provision
```


You can then reboot Vagrant to cause the newly added site to be initialized.
**NB: If you are running Windows, make sure [`private/vvv-init.sh`](private/vvv-init.sh) has LF line endings**:

```bash
vagrant reload --provision
```

Once this finishes, you should be able to access **[vvv.[site].com](http://vvv.[site].com/)** from your browser. The default WordPress username and password is `dev`.

If commands complain about needing to be run in Vagrant, you first can `vagrant ssh` then `cd /srv/www/[site].com`
to run the command, or do:

```bash
vagrant ssh -c 'cd /srv/www/[site].com && wp some command'
```
## Debugging
VVV ships with some powerful code debugging tools just a command away. Using these tools will make you a smarter, more powerful, and better informed developer.

### WordPress Debugging
Both the default and trunk versions of WordPress that ship with VVV have wp_debug turned on. If you installed your own version, ensure this is the case. Find `wp-config-local.php`. You need a line somewhere in the file that says the following:

````php
define( 'WP_DEBUG', true );
````

If this is new to you, it's suggested that you view your site now. If there are PHP notices or errors, they will be output to the screen.

### Other, standard methods of debugging
**Var_dump Debugging** uses `var_dump($var); die();` to inspect variables at different points in the code. This is a sledgehammer, but is effective. It will show you variable information, then kill all script execution past that point. Without xDebug, it's pretty ugly, so you might wrap it with `<pre></pre>`

In the WordPress.org plugin repository is the **Debug Bar** and **Debug Bar Extender**. The latter has some functions that allow you to more elegantly output variables to the debug bar. There are more plugins available for the debug bar to help diagnose specific issues: Cron, Rewrites, and Post Meta.

If you are getting a blank screen, or maybe have PHP errors, you can view the PHP errors logs on your vagrant at `/srv/log/php_errors.log`. To do so connect to your vagrant using `vagrant ssh` and then view your logs using `sudo tail -f /srv/log/php_errors.log`. You can also use the bundled script `bash private/tail-vvv-php-error-log.sh` If you have defined `WP_DEBUG` to `true` in your site's `wp-config.php`, the logs will instead be in the site's `wp-content` folder, at `wp-content/debug.log`.

Finally, when you've just about given up hope, **Rubber Duck Debugging** is a last resort. Turn to the rubber duck you keep on your desk (you do keep a rubber ducky on your desk, right?) and explain the problem. By the end, you may have an answer.

## Meet xDebug
Did I say last resort? Clearly I meant it's the last resort if you don't know about xDebug. This fantastic extention to PHP is pre-compiled in VVV and is waiting to be turned on.

### Turning on xDebug
1. Open a console window, and `cd` into your vagrant directory.
2. SSH into vagrant: `vagrant ssh`.
3. Turn on xDebug: `xdebug_on`

![Gif showing xdebug being turned on and off using the above steps.](https://raw.github.com/wiki/varying-vagrant-vagrants/vvv/media/turning-xdebug-on.gif)

xDebug configuration will be added to your php.ini and php5-fpm will be restarted. You can modify your version of xdebug by editing `/config/php5-fpm-config/xdebug.ini` and restarting php5-fpm.

Hint: a convenient way to restart php5-fpm is to run `xdebug_on` or `xdebug_off`. You can also run `sudo service php5-fpm restart`

### Prettier errors
xDebug wraps PHP errors in an HTML table with some rather striking colors that are sure to get your attention. Oh, and a very useful stack trace.

![Image comparing the display of PHP errors and warnings with xdebug on and off](https://raw.github.com/wiki/varying-vagrant-vagrants/vvv/media/xdebug-errors-output.png)

### Prettier var_dumps
Var_dump() is now formatted and syntax highlighted.

![Image comparing the display of var_dump() with xdebug on and off](https://raw.github.com/wiki/varying-vagrant-vagrants/vvv/media/xdebug-var-dump-output.png)

### Step-through, Remote Debugging
xDebug also provides a powerful tool not available without it: remote debugging. Chiefly, this allows you to pause PHP execution and run through the stack one function at a time, inspect values, change variables, evaluate functions at a specific point during execution. Basically you see _precisely_ what your code is doing when it runs.

#### Setting up remote debugging
Once xDebug is turned on, the only thing needing further configuration is your client. Most IDE's will have support for remote debugging and there are some standalone clients. The xDebug Documentation has a [full list](http://xdebug.org/docs/remote)

**[View a screencast of setting up path mappings in PHPStorm](http://www.youtube.com/watch?v=EsL6mAFEsvY)**

Our xDebug configuration is set to automatically start on every request and attempt to connect to a client on the default port 9000.

Because VVV uses mapped folders, the `www` directory _as it appears to PHP_ is in `/srv/www`. It may be in a completely different place on your local machine. Therefore, you'll likely need to specify path mappings to relate the two.

* [Path mappings in PHPStorm](http://www.jetbrains.com/phpstorm/webhelp/override-server-path-mappings-dialog.html)
* [Path mappings in Netbeans](https://blogs.oracle.com/netbeansphp/entry/path_mapping_in_php_debugger)
* [Path mappings in Eclipse](http://www.eclipse.org/pdt/help/html/path_mapping.htm)
* [Path mappings in MacGDBp](http://www.bluestatic.org/software/macgdbp/help.php#remote-paths)
* [Path mappings in SublimeText 3 for SublimeTextXdebug](https://gist.github.com/CamdenSegal/0f975cbf5131edc14c80)
* [Path mappings in Vdebug](https://github.com/joonty/vdebug/blob/master/doc/Vdebug.txt#L1046)

Note: The above links are the result of searching, the only one that has been verified accurate is PHPStorm. Unfortunately, it's also the most confusing. Pull requests with more detailed walkthroughs are welcome.

### Cachegrind
So thanks to all these fancy debugging tools your script is running. But how _well_ is it running? VVV is now shipping with profiling tools.

Basic profiling, it should be noted, can be accomplished using the Debug Bar Extender profiling tools. For more accurate, more robust, and more awesome profiling, keep reading.

Once you turn on xdebug (remember: `xdebug_on` while SSH'd into Vagrant), you'll have the profiler immediately available. Make any URL request and append ?XDEBUG_PROFILE and a cachegrind file will be generated.

Cachegrind files can be evaluated by a few external programs, but we've built in [Webgrind](https://github.com/jokkedk/webgrind) to VVV. On a default installation, visit [http://192.168.50.4/webgrind](http://192.168.50.4/webgrind/).

### Try this now

If you have a default VVV box installed per the instructions

1. If xDebug isn't turned on (or you aren't sure), follow the instructions above
2. Visit [http://local.wordpress-trunk.dev/?XDEBUG_PROFILE](http://local.wordpress-trunk.dev/?XDEBUG_PROFILE). This will generate a cachegrind file in /tmp
3. Go to Webgrind at [http://192.168.50.4/webgrind](http://192.168.50.4/webgrind/)
4. Click "update" in the upper right. The Auto (newest) drop down will allow you to select from older cachegrind files.

### Interpreting a cachegrind file
WebGrind will show you (by default) the top 90% of functions, methods, and includes of the latest cachegrind file by percent (of time the total execution time).

Columns:

* Type of item: function, method, or include
* Function name
* Jump to code button
* Invocation Count: how many times this item is run
* Self Cost: cost of this item, but not anything it calls
* Total Cost: cost of this item, including what it calls

![Screenshot of webgrind's cachegrid analysis](https://raw.github.com/wiki/varying-vagrant-vagrants/vvv/media/webgrind-example.png)

#### Type of Item
* Internal (PHP) function — blue
* Included or Required file — grey
* class methods — green
* regular, or procedural, functions — orange

#### Function name
Clicking on a function or item name will show you all of the functions and methods that it calls and anything that it is called from. This allows you to take any function and walk up or down in the execution tree to find the real bottleneck.

### Jump to code button
This amazing little button will jump to a syntax-highlighted, line-numbered HTML page and show you the function, method, or include in context.

### Invocation Count
See _exactly_ how many times `apply_filters()` is called. Hint: lots and lots.

### Self Cost
Depending on what you selected in the upper right—percent, miliseconds, or microseconds—the units will differ, but the meaning is the same. This gives the relative weight of this function, method, or include by itself. That is, it's weight without considering all of the functions, methods, or includes that it calls.

### Total Cost
Conversely, total cost counts everything that a function, method, or include calls. "{Main}"" should always have a total cost of 100%, since it will include the cost of every function, method, or include that runs.

You can tail the error log in VVV by invoking the bundled script from your host machine:

```bash
bash private/tail-vvv-php-error-log.sh
```


## Upgrading wp core from pantheons upstream

Pantheon will prompt you when there are upstream updates for WordPress Core to install. If there is a conflict (e.g. in `README.md`) then you can manually merge from the upstream via:

```bash
git remote add upstream https://github.com/pantheon-systems/WordPress.git
git checkout master
git pull -X mine upstream master
git checkout origin/master -- readme.html # any files that you modified
git diff --staged # sanity check
git commit
git push origin master
```

There is a script for updating plugins. You can define the plugins from WordPress.org to keep updated by creating a file `private/wordpress-org-plugins.txt` which contains a list of the slugs you want to update:

```
wp-redis
jetpack
customize-widgets-plus
```

You can then run [`private/update.sh`](private/update.sh) inside of Vagrant (you'll want to make sure you have first [set your git identity](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup#Your-Identity) inside of Vagrant).

Any additional update logic can be committed to `private/update-custom.sh`.

You can also get the latest from this repo via:

```bash
git pull https://github.com/[site]/pantheon-wordpress-upstream.git master
```
## Code Review
When you are done writing a feature or bugfix the code gets to the review stage. At code review the code `Author` adds a `tester` [team member aware of the feature and another reviewer with more 'domain' knowledge and a few other team members[optional due to availability].
A review is initialized when a pull request to the 'master' branch of the repo is made. This triggers automated tests and linter checks as a last step before deploying to pantheon. 


## Public Environments and Deployments

The site is hosted with Pantheon.

You can deploy code manually to the dev site [`dev-[site].pantheon.io`](http://dev-[site].pantheon.io/) by pushing commits to the `master` branch on the Pantheon repo.
(Ideally, however, this GitHub repo is set up with Travis CI to push commits to Pantheon when builds pass.)
To push directly to Pantheon, first make sure you first [add your SSH key to your Pantheon account](https://pantheon.io/docs/articles/users/generating-ssh-keys/#add-the-key-to-your-pantheon-account), and then
you can add the Pantheon repo as a remote on you existing GitHub clone:

```bash
git remote add pantheon ssh://codeserver.dev.[siteUID]@codeserver.dev.[siteUID].drush.in:2222/~/repository.git
```

Then you can deploy simply by merging any feature branches into the `production` branch on GitHub, and then just do:

```bash
git checkout production
git pull && git merge master
git push origin production
```

You can then [promote the code](https://dashboard.pantheon.io/sites/[siteUID]#test/deploys) to the [test environment](http://test-[site].pantheon.io/) before deploying it to production via the Pantheon dashboard.

Power users will want to check out the [Pantheon CLI](https://github.com/pantheon-systems/cli) which allows you to do a lot of [administrative functions](https://github.com/pantheon-systems/cli/wiki/Available-Commands) (including deployments) as well as any WP-CLI command. To do a deployment to staging (test), for instance:

```bash
terminus site deploy --site=[site] --env=test --from=dev
```

## UAT [User Acceptance tests] and Automated tests.
User Acceptance Tests are carried out on the [test environment](http://test-[site].pantheon.io/) to ensure visual acceptance, heavyier behavioural tests that run frequently will be carried out on [dev environment](http://dev-[site].pantheon.io/) and vice versa as per availability.

To clone the content on the production website to the other environments simply run the following script and follow the prompt. 

## Code Rollbacks
There may be instances where a deploy goes wrong, eg regression tests dont catch a change, code deployed is not according to spec, a deploy fails UAT.This codebase is fully versioned see [releases](https://github.com/[site]/[site]-cms/releases). With tags for the git repo v-0.1.xxx , for test env pantheon_test_302 and live pantheon_live_302 respectively.
To rollback to a specific release, checkout the release tag and push to pantheon. NB releases shuld have notes explaining the intent of the release and/ or what it fixes for clarity and easy incident escalation management. READ Hotfox below for alternate procedure.

## Hotfix
Hotfixes are discouraged and are only allowed in certain cases as stipulated here 
[Pantheon hotfix](https://pantheon.io/docs/hotfixes/)

## Notifications and integrations

## Production site info

The production site is located at [https://[site].com/](https://[site].com/)

[2]: https://github.com/Varying-Vagrant-Vagrants/VVV
[3]: https://github.com/Varying-Vagrant-Vagrants/VVV#the-first-vagrant-up
[4]: https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards
[5]: https://github.com/gulpjs/gulp


## Code specific documentation can be found in folders within the codebase explaining specific portions and usage.
