# birGit / birgit / Birgit / b
Git helper

* This amazing software will be presented at [FSCONS 2015](https://www.google.se/search?q=fscons&oq=fsc&aqs=chrome.0.69i59j69i57j69i60l3j69i65.3855j0j7&sourceid=chrome&es_sm=0&ie=UTF-8)

to list commands just write ./birgit

to run a command write ./birgit [command]

to add a command put a file in birgit_ folder

add birgit to your path in your .bashrc or .zhrc or where you want.
i also recomend to use alias b

---

# Presentation

* Author: Patrik Gustafsson
* content: [https://github.com/paven/birGit/](https://github.com/paven/birGit/blob/master/README.md)
* [as slides](http://www.mumma.nu/birGit)

---

# birGit / birgit / Brigit / b

birGit is an git tool that allows you to easily use the power of the command line in together with git. This softwares main focus is to bring down (multiline) long git commands to simple commands.

---

# Birgit: 

* is git comands that with out birgit is to complex to use. 
* has an amazing easy to expand file/folder code structure 
* returns results with atomic rows. 
* is written in bash. 
* is your source of power

---

# Content

This talk will introduce you to birGit.


How to: 
* use birGit 
* know birGit
* expand birGit 
* send birGit patches to the main project. 
* how birGit was made with opensource in mind.

---

# use birGit - installation

    cd ~/bin
    git clone https://github.com/paven/birGit.git
    echo "export PATH=$PATH:~/bin/birGit/" >> ~/.profile

optional:

    echo "alias b=birgit" >> ~/.profile

---

# use birGit - list

    b

list all commands in birgit

---

# know birgit - list

executable files in a folder

    cat ~/bin/birGit/birgit

some code is just perfekt

---

# use birGit - log

    b log

displays the git log in a nice way

---

# know birgit - log

    cat ~/bin/birGit/birgit_/log

---

# use/know birgit - root

    b root

path to git root

---

# use/know birgit - amend

    b amend <commitish>

some code is under development...

# use/know birgit - rebase

    b rebase

some commands shape the way you work

---

# know birgit - design choises

1. birigt should return results that are easy to pipe
2. birigt should produce the same result independent of where in the repository you are standing with in you repository.
3. birgit should be like you firm but kind grandmother

---

# expand birGit - clone

[![Fork](https://raw.github.com/paven/birGit/master/README/fork.png)](https://github.com/paven/birGit)

    cd ~/bin
    rm -r birGit
    git clone git@github.com:paven/birGit.git

use you repo

# expand birGit - pullRequest

    git commit . "Sane discription of change"
    	git push

[pull request](https://github.com/paven/birGit/compare)

---

# more code