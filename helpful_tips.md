go through the list of stash and drops any work in progress stashes.   
most of the time these end up being temp work, or helpful pause points that don't server a purpose  
You should always save your stash with a message if it is important  
``` bash
git stash list | grep -i "WIP" | cut -c-10 | tr -d : | tac | xargs -L 1 git stash drop
```

JS script to compile GL messages into a pastable list. This excludes any merge commits.  
works on the compare, tags, and merge request pages. run in your browsers console  
``` js
if (location.href.match(new RegExp('tags/v'))) {
    content = location.href+'<br />```<br>';
    $('div.wiki li, div.wiki p').each((i, val) => {
       content += $(val).html()+'<br>';
    });
    $('.description').html(content+'```');
} else {
$('li.commit').filter(':not(:contains(Merge branch))').each(function () {
    $('.panel-default, #content-body').css({'padding-top': '1em'});
    $('.panel-default, #content-body').first().prepend(
      $('<div style="margin-left: 2em">* '+$(this).find('.item-title').text()+'</div>')
    )
});
}
```
