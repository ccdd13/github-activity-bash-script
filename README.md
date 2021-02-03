# GitHub Activity Demo Script

[![support-me-w-bitcoins](https://img.shields.io/badge/bitcoins-payment%20request%20to%20https://github.com/ccdd12-brightgreen)](https://blockchain.com/btc/payment_request?address=1Nm2q6VjDcabFVhS6HyYdUzUWbUkg1)

This script aims to prove why you should not be too quick at judging people by their GitHub activity stats.

The script will turn your contributions graph from this:

![GitHub Activity Before](https://imgur.com/SFQ3RJz.png)

Into this:

![GitHub Activity After](https://imgur.com/xJ6MjFH.png)

In 20-30 seconds.

> Use for demo purposes only!

To execute just run the following commaind inside a demo repository:

1. First download the script
2. After that run the script
3. Finally, push your changes to GitHub

# Get started

```bash
export ACTIVITY_BR=main ; export MAX_PAST_DAYS=365 ; export COMMIT_NB= ; export COMMIT_MAX=7 ; \
curl -sL https://raw.githubusercontent.com/ccdd12/github-activity-bash-script/main/activity.sh \
 | bash ;
```

# Install

```bash
bash -c 'UPDATE_BIN="${HOME}/.local/bin" ; \
curl -sL https://raw.githubusercontent.com/ccdd12/github-activity-bash-script/main/activity.sh \
     --output ${UPDATE_BIN}/${gh-gen-activity.sh} && \
${UPDATE_BIN}/${gh-gen-activity.sh} --update && \
${UPDATE_BIN}/${gh-gen-activity.sh} --interactive --branch=main --past=365 --commit-max=10 '
```

# Documentation

<table>
  <thead>
    <tr>
      <th style="font-weight: bold;text-align:center">env</th>
      <th style="font-weight: bold;text-align:center">description</th>
      <th style="font-weight: bold;text-align:center">type</th>
      <th style="font-weight: bold;text-align:center">default value</th>
      <th style="font-weight: bold;text-align:center" colspan="2" >command line arguments</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:center"><code>ACTIVITY_BR</code></td>
      <td style="text-align:center">working git branch</td>
      <td style="text-align:center"><code>string</code></td>
      <td style="text-align:center"><code>main</code></td>
      <td style="text-align:center"><code>--branch | --br | -b <i>{value}</i></code></td>
      <td style="text-align:center"><code>--branch=<i>{value}</i></code></td>
    </tr>
    <tr>
      <td style="text-align:center"><code>MAX_PAST_DAYS</code></td>
      <td style="text-align:center">number of past days</td>
      <td style="text-align:center"><code>integer</code></td>
      <td style="text-align:center"><code>365</code></td>
      <td style="text-align:center"><code>--past | -p <i>{value}</i></code></td>
      <td style="text-align:center"><code>--past=<i>{value}</i></code></td>
    </tr>
    <tr>
      <td style="text-align:center"><code>COMMIT_NB</code></td>
      <td style="text-align:center">exactly git commit number each past day.</td>
      <td style="text-align:center"><code>integer</code></td>
      <td style="text-align:center">∅</td>
      <td style="text-align:center"><code>--commit-nb | --nb | -n <i>{value}</i></code></td>
      <td style="text-align:center"><code>--commit-nb=<i>{value}</i> | --nb=<i>{value}</i></code></td>
    </tr>
    <tr>
      <td style="text-align:center"><code>COMMIT_MAX</code></td>
      <td style="text-align:center">randomly git commit number each past day between [1…max]. <b>used only if <code>COMMIT_NB</code> is empty.<br/>if both <code>COMMIT_MAX</code> and <code>COMMIT_NB</code> empty, randomly commit number each past day between <code>[1..7]</code></b></td>
      <td style="text-align:center"><code>integer</code></td>
      <td style="text-align:center"><code>7</code></td>
      <td style="text-align:center"><code>--commit-max | --max | -m <i>{value}</i></code></td>
      <td style="text-align:center"><code>--commit-max=<i>{value}</i> | --nb=<i>{value}</i></code></td>
    </tr>
    <tr>
      <td style="text-align:center"><code>GITHUB_AUTHOR</code></td>
      <td style="text-align:center">owner of github repo to update from</td>
      <td style="text-align:center"><code>string</code></td>
      <td style="text-align:center"><code>ccdd12</code></td>
      <td style="text-align:center"><code>--gh-author <i>{value}</i></code></td>
      <td style="text-align:center"><code>--gh-author=<i>{value}</i></code></td>
    </tr>
    <tr>
      <td style="text-align:center"><code>REPONAME</code></td>
      <td style="text-align:center">github repo to update from</td>
      <td style="text-align:center"><code>string</code></td>
      <td style="text-align:center"><code>github-activity-bash-script</code></td>
      <td style="text-align:center"><code>--reponame <i>{value}</i></code></td>
      <td style="text-align:center"><code>--reponame=<i>{value}</i></code></td>
    </tr>
    <tr>
      <td style="text-align:center"><code>ASSET_FILENAME</code></td>
      <td style="text-align:center">release asset filename to download</td>
      <td style="text-align:center"><code>string</code></td>
      <td style="text-align:center"><code>gh-gen-activity.sh</code></td>
      <td style="text-align:center"><code>--asset-fname <i>{value}</i></code></td>
      <td style="text-align:center"><code>--asset-fname=<i>{value}</i></code></td>
    </tr>
    <tr>
      <td style="text-align:center"><code>UPDATE_BIN</code></td>
      <td style="text-align:center">update and install to given path</td>
      <td style="text-align:center"><code>string</code></td>
      <td style="text-align:center"><code>${HOME}/.local/bin</code></td>
      <td style="text-align:center"><code>--update <i>{value}</i></code></td>
      <td style="text-align:center"><code>--update=<i>{value}</i></code></td>
    </tr>
    <tr>
      <td style="text-align:center"><code>SELECTED_UPDATE_FUN</code></td>
      <td style="text-align:center"><code>bash</code> <code>function</code> to run when update requested. <b>this foes not launch update action</b></td>
      <td style="text-align:center"><code>string</code></td>
      <td style="text-align:center"><code>update_ghrelease</code> | <code>update_ghrepo</code> | <code>update_ghpage</code></td>
      <td style="text-align:center"><code>--update-fun <i>{value}</i></code></td>
      <td style="text-align:center"><code>--update-fun=<i>{value}</i></code></td>
    </tr>
    <tr>
      <td style="text-align:center">∅</td>
      <td style="text-align:center">interactive mode, ask user to create repo on github and push to it automatically. <b color="style:red;">does not work in pipe (ex. <code>curl -sL https://...../activity.sh | bash</code>)</b></td>
      <td style="text-align:center" colspan="2">∅</td>
      <td style="text-align:center" colspan="2"><code>--interactive | -i</code></td>
    </tr>
  </tbody>
</table>

# Introduction to Bash Scripting

In case that you are interested in learning more about Bash Scripting, make sure to checkout this open-source eBook:

**[Introduction to Bash Scripting](https://github.com/bobbyiliev/introduction-to-bash-scripting)**

# Blog Post

[Here is why you should not be too quick at judging people by their GitHub activity stats](https://devdojo.com/bobbyiliev/here-is-why-you-should-not-be-too-quick-at-judging-people-by-their-github-activity-stats?ref=bobbyiliev)
