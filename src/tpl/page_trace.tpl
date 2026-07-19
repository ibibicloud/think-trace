<style>
#think_page_trace{
    position: fixed;
    right: 0;
    bottom: 0;
    width: 100%;
    z-index: 999999;
    font-family:
        "Source Code Pro", "Inter",
        -apple-system, BlinkMacSystemFont,
        "Segoe UI", "Helvetica Neue",
        "PingFang SC", "Hiragino Sans GB",
        sans-serif;
    font-size: 14px;
}
#think_page_trace_tab{
    display: none;
    height: 300px;
    background: #fff;
    margin: 0;
}
#think_page_trace_tab_tit{
    font-size: 16px;
    height: 28px;
    padding: 3px 12px;
    border-top: 1px solid #d8d8d8;
    border-bottom: 1px solid #d8d8d8;
}
#think_page_trace_tab_tit>span{
    color: #000;
    padding-right: 12px;
    height: 28px;
    line-height: 28px;
    display: inline-block;
    margin-right: 3px;
    cursor: pointer;
    font-weight: 700;
}
#think_page_trace_tab_cont{
    overflow: auto;
    height: 262px;
    padding: 0;
    line-height: 24px;
}
#think_page_trace_tab_cont>div{
    display: none;
}
#think_page_trace_tab_cont>div>ol{
    padding: 0;
    margin: 0;
}
#think_page_trace_tab_cont>div>ol>li{
    border-bottom: 1px solid #eee;
    padding: 0 12px;
}
#think_page_trace_close{
    display: none;
    text-align: right;
    height: 15px;
    position: absolute;
    top: 10px;
    right: 12px;
    cursor: pointer;
    z-index:  999999;
}
#think_page_trace_open{
    height: 28px;
    float: right;
    text-align: right;
    overflow: hidden;
    position: fixed;
    bottom: 0;
    right: 0;
    color: #000;
    line-height: 28px;
    cursor: pointer;
    z-index: 999999;
}
#think_page_trace_open>div{
    background: #333;
    color: #fff;
    padding: 0 6px;
    float: right;
    line-height: 28px;
    font-size: 14px;
}
</style>

<div id="think_page_trace">
    <div id="think_page_trace_tab">
        <div id="think_page_trace_tab_tit">
            <?php foreach ($trace as $key => $value) {?>
            <span><?php echo $key ?></span>
            <?php }?>
        </div>
        <div id="think_page_trace_tab_cont">
            <?php foreach ($trace as $info) {?>
            <div>
                <ol>
                    <?php
                    if (is_array($info)) {
                        foreach ($info as $k => $val) {
                            echo '<li>' . (is_numeric($k) ? '' : $k.' : ') . htmlentities(print_r($val,true), ENT_COMPAT, 'utf-8') . '</li>';
                        }
                    }
                    ?>
                </ol>
            </div>
            <?php }?>
        </div>
    </div>
    <div id="think_page_trace_close">
        <span>X</span>
    </div>
</div>
<div id="think_page_trace_open">
    <div>
        调试：
        <?php echo number_format(microtime(true)-\think\facade\App::getBeginTime(), 6, '.', '').'s ';?>
    </div>
</div>

<script type="text/javascript">
    (function(){
        var tab_tit  = document.getElementById('think_page_trace_tab_tit').getElementsByTagName('span');
        var tab_cont = document.getElementById('think_page_trace_tab_cont').getElementsByTagName('div');
        var open     = document.getElementById('think_page_trace_open');
        var close    = document.getElementById('think_page_trace_close').children[0];
        var trace    = document.getElementById('think_page_trace_tab');
        var cookie   = document.cookie.match(/thinkphp_show_page_trace=(\d\|\d)/);
        var history  = (cookie && typeof cookie[1] != 'undefined' && cookie[1].split('|')) || [0,0];
        open.onclick = function(){
            trace.style.display = 'block';
            this.style.display = 'none';
            close.parentNode.style.display = 'block';
            history[0] = 1;
            document.cookie = 'thinkphp_show_page_trace='+history.join('|')
        }
        close.onclick = function(){
            trace.style.display = 'none';
            this.parentNode.style.display = 'none';
            open.style.display = 'block';
            history[0] = 0;
            document.cookie = 'thinkphp_show_page_trace='+history.join('|')
        }
        for(var i = 0; i < tab_tit.length; i++){
            tab_tit[i].onclick = (function(i){
                return function(){
                    for(var j = 0; j < tab_cont.length; j++){
                        tab_cont[j].style.display = 'none';
                        tab_tit[j].style.color = '#999';
                    }
                    tab_cont[i].style.display = 'block';
                    tab_tit[i].style.color = '#000';
                    history[1] = i;
                    document.cookie = 'thinkphp_show_page_trace='+history.join('|')
                }
            })(i)
        }
        parseInt(history[0]) && open.click();
        tab_tit[history[1]].click();
    })();
</script>
