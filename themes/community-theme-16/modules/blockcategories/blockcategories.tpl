{if !empty($blockCategTree) && !empty($blockCategTree.children)}
  <section id="blockcategories" class="blockcategories block">
    <h4 class="title_block">{l s='Categories' mod='blockcategories'}</h4>
    <div class="list-group">
      {foreach from=$blockCategTree.children item=list_item_child}
        {include file='./list_group_item.tpl' list_item=$list_item_child level=1}
      {/foreach}
    </div>
  </section>
{/if}

{literal}
<script type="text/javascript">
  $(function() {
    var $menus = $('.blockcategories');

    $menus.each(function() {
      var $collapse = $(this).find('.collapse');
      var $triggers = $(this).find('.btn-toggle');

      $collapse.on('show.bs.collapse', function() {
        var $target = $(this);
        var $targetAndParents = $target.parents().filter('.collapse').add($target);

        // Collapse all other menus which are not in the current tree
        $collapse.filter('.collapse.in').not($targetAndParents).collapse('hide');

        // Add 'active' class to triggers which show this element
        $triggers.filter('[href="#' + $target.prop('id') + '"],' +
          '[data-target="#' + $target.prop('id') + '"]').parent().addClass('active');
      });

      $collapse.on('hide.bs.collapse', function(e) {
        // Fixes event being handled twice (event is trigger twice). WTF? @bootstrap, @jquery
        if (e.handled) {
          return;
        } else {
          e.handled = true;
        }

        // Remove 'active' class from triggers which show this collapse element
        $triggers.filter('[href="#' + $(this).prop('id') + '"],' +
          '[data-target="#' + $(this).prop('id') + '"]').parent().removeClass('active');
      });
    });
  });
</script>
{/literal}
