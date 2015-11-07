# birGit / birgit / Birgit / b
Git helper

* This amazing software will be presented at [FSCONS 2015](https://www.google.se/search?q=fscons&oq=fsc&aqs=chrome.0.69i59j69i57j69i60l3j69i65.3855j0j7&sourceid=chrome&es_sm=0&ie=UTF-8)

to list commands just write ./birgit

to run a command write ./birgit [command]

to add a command put a file in birgit_ folder

add birgit to your path in your .bashrc or .zhrc or where you want.
i also recomend to use alias b

---

# me

* Author: [Patrik Gustafsson](http://www.purplescout.se/project/patrik-gustafsson/)
* content: [https://github.com/paven/birGit/](https://github.com/paven/birGit/blob/master/README.md)
* [as slides](http://www.mumma.nu/birGit)

---

# birGit / birgit / Birgit / b

birGit is an git tool that allows you to easily use the power of the command line in together with git. This softwares main focus is to bring down (multiline) long git commands to simple commands.

---

# birGit

* is git comands that with out birgit is to complex to use. 
* has an amazing easy to expand file/folder code structure 
* returns results with atomic rows. 
* is written in bash. 
* is your source of power

---

# content

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

# use birGit

    b

list all commands in birgit

---

# use birGit - log

    b log

displays the git log in a nice way

---

# use birgit - root

    b root

path to git root

---

# use birgit - rebase

    b rebase

rebase you work on origin/master

---

# use birgit - amend

    b amend <commitish>

some code is under development...
this one jumps back to a previus commit.. and ammends it.

---

# know birgit

executable files in a folder

    cat ~/bin/birGit/birgit

some code is just perfekt

---

# know birgit - design choises

1. birigt reports should return results that are easy to pipe
2. birigt should produce the same result independent of where in the repository you are standing with in you repository.
3. birgit should be like you firm but kind grandmother

---

# know birgit - log

    cat ~/bin/birGit/birgit_/log

A simple example

---

# know birgit - ammend

    cat ~/bin/birGit/birgit_/ammend

A complex example

---

# expand birGit - clone

[![Fork](https://raw.github.com/paven/birGit/master/README/fork.png)](https://github.com/paven/birGit)

    cd ~/bin
    rm -r birGit
    git clone git@github.com:paven/birGit.git

use you repo

---

# expand birGit - pullRequest

    git commit . "Sane discription of change"
    git push

[pull request](https://github.com/paven/birGit/compare)

---

# alternatives

* your own scripts..
* git alias
* shell alias

---

# more time = more code

---

