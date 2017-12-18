    jQuery(function() {
    	uploader = new Array();//创建 uploader数组
    	// 优化retina, 在retina下这个值是2
        var ratio = window.devicePixelRatio || 1,
        supportTransition = (function(){
            var s = document.createElement('p').style,
            r = 'transition' in s ||
                  'WebkitTransition' in s ||
                  'MozTransition' in s ||
                  'msTransition' in s ||
                  'OTransition' in s;
	        s = null;
	        return r;
        })();

     	// 所有文件的进度信息，key为file id
        var percentages = {};
        var state = 'pedding';
    	//可行性判断
    	if ( !WebUploader.Uploader.support() ) {
            alert( 'Web Uploader 不支持您的浏览器！如果你使用的是IE浏览器，请尝试升级 flash 播放器');
            throw new Error( 'WebUploader does not support the browser you are using.' );
        }

    	//循环页面中每个上传域
    	$('.hiUploder').each(function(index){
    		// 添加的文件数量
            var fileCount = 0;
            // 添加的文件总大小
            var fileSize = 0;
    		var hiPicker = $(this).find('.hiPicker');           //上传按钮实例
    		var queueList = $(this).find('.queueList');         //拖拽容器实例
    		var hiFilePicker = $(this).find('.hiFilePicker');   //继续添加按钮实例
    		var placeholder = $(this).find('.placeholder');     //按钮与虚线框实例
    		var statusBar = $(this).find('.statusBar');         //再次添加按钮容器实例
    		var info = statusBar.find('.info');                 //提示信息容器实例
            //传送当前表单数据
            var inputname = $(this).find('.hiPicker').attr("name");         //表单名
            var limit = $(hiPicker).attr("limit") ? $(hiPicker).attr("limit"):1;               //验证文件总数量, 超出则不允许加入队列
            var value = $(this).find('.hiPicker').attr("value");
            var url = hi.url_upload_file;                //上传地址
            var mult = (limit == 1)?false:true;   //是否开起同时选择多个文件
            
    		// 容器
    		var queue = $('<ul class="filelist"></ul>').appendTo( queueList);
    		
    		//初始化上传实例
            /*if(!url || !inputname){
                $(hiPicker).parent().parent().remove();
            }*/
            //表单名
            if(limit != 1) inputname = inputname + '[]';

            //WEBUPLOADER
            uploader[index] = WebUploader.create({
                pick: {
                    id: hiPicker,
                    //label: '选择图片',   //按钮文字
                    multiple: mult         //是否多选
                },
                //dnd: queueList,
                //这里可以根据 index 或者其他，使用变量形式
                accept: {
                    title: 'Files',
                    extensions: 'txt',
                    //mimeTypes: 'image/jpg,image/jpeg,image/png'
                },
                // swf文件路径
                swf: 'res/Uploader.swf',
                disableGlobalDnd: true,//禁用浏览器的拖拽功能，否则图片会被浏览器打开
                chunked: false,//是否分片处理大文件的上传
                //server: 'fileUpload.do',//上传地址
                server: url,
                fileNumLimit: limit,//一次最多上传文件个数
                fileSizeLimit: 10 * 1024 * 1024,    // 总共的最大限制10M
                fileSingleSizeLimit: 5 * 1024 * 1024 ,   // 单文件的最大限制3M
                auto :true,
                formData: {
                	token:index//可以在这里附加控件编号，从而区分是哪个控件上传的
                }
            });

            // 添加“添加文件”的按钮
            /*uploader[index].addButton({
                id: hiFilePicker,
                label: '继续添加'
            });*/

            // 当文件加入队列时触发	uploader[0].upload();
            uploader[index].onFileQueued = function( file ) {
    			fileCount++;
                fileSize += file.size;
                if ( fileCount > 1 ) {
                	placeholder.addClass( 'element-invisible' );
                    statusBar.show();
                }
                /*if(fileCount >= limit){
                    layer.msg("请先移除对应图片！", { icon: 5, time: 1500, shift: 6 });
                    return false;
                }*/

                addFile( file,uploader[index],queue, inputname);
                setState( 'ready' ,uploader[index],placeholder,queue,statusBar,hiFilePicker);
                updateStatus('ready',info,fileCount,fileSize);
            };

    		// 当文件被移除队列后触发。
            uploader[index].onFileDequeued = function( file ) {
            	fileCount--;
                fileSize -= file.size;
                if ( !fileCount ) {
                    setState( 'pedding',uploader[index],placeholder,queue,statusBar,hiFilePicker);
                    updateStatus('pedding',info,fileCount,fileSize);
                }
                removeFile( file );
            };

            // 20170420 修正服务端返回错误信息
            uploader[index].on('uploadAccept', function(file, response) {
                console.log(response);
                console.log(file);
                if (response.status == 0) {
                    // 通过return false来告诉组件，此文件上传有错。
                    layer.msg( response.info , { icon: 5, time: 1500, anim: 6 });
                    uploader[index].removeFile(file.file);
                    return false;
                }
            });

            // 上传失败
            /*uploader[index].on('uploadError',function(file, res){
                console.log(file);
                //layer.msg( res.info , { icon: 5, time: 1500, anim: 6 });
            });*/

            // 上传成功
            uploader[index].on('uploadSuccess',function(file,res){
                var $li = $( '<li id="' + file.id + '"></li>' );
                //$li.append( '<span class="success"></span>' );
                $("#"+file.id).find('input').val(res.id);
            });

            // 可以在这里附加额外上传数据
            uploader[index].on('uploadBeforeSend',function(object,data,header) {
            	/*var tt=$("input[name='thumb']").val();
            	data=$.extend(data,{
            		modelid:tt
            		});
                alert(data);*/
            });

            // 当文件被加入队列之前触发
            uploader[index].on('beforeFileQueued',function(file){
                if(fileCount >= limit){
                    layer.msg("最多只能上传" + limit + "个文件", { icon: 5, time: 1500, shift: 6 });
                    return false;
                }
            });

            // 发送错误通知
            uploader[index].on("error",function (type){
                 if(type == "F_DUPLICATE"){
                    layer.msg('选择的文件有重复', { icon: 5, time: 1500, shift: 6 });
                 }else if(type == "Q_EXCEED_SIZE_LIMIT"){
                    layer.msg("所选附件不能超过500k", { icon: 5, time: 1500, shift: 6 });
                 }else if(type == "Q_TYPE_DENIED"){
                    layer.msg("文件类型错误", { icon: 5, time: 1500, shift: 6 });
                 }else if(type == "Q_EXCEED_NUM_LIMIT"){
                    layer.msg("不能超过设置的文件数量", { icon: 5, time: 1500, shift: 6 });
                 }
             });

            //加载的时候，页面加载的时候模拟文件加入队列进行图片的编辑回显
            uploader[index] .on('ready',function(){
                $.ajax({
                    url:'/index.php?s=/Center/Upload/getPicture/ids/' + value + '/index=' + index,//数据库获取文件信息
                    type:'GET',
                    async:false,
                    success:function(files){
                        //console.log(files);
                        var files = eval('('+files+')');
                        for(var i = 0; i < files.length; i++){
                            var obj ={};
                            statusMap = {};
                            fileCount++;
                            fileSize += files[i].size;
                            if ( fileCount === 1 ) {
                                placeholder.addClass( 'element-invisible' );
                                statusBar.show();
                            }
                            obj.id         = 'WUC_' + i;
                            //obj.id         = files[i].id;
                            obj.name       = files[i].name;
                            obj.type       = files[i].mime;
                            obj.size       = files[i].size;
                            obj.ret        = files[i].path;
                            obj.inputValue = files[i].id;
                            obj.source=this;
                            obj.flog=true;
                            obj.status = 'complete',
                            obj.getStatus = function(){
                                return '';
                            }
                            obj.version = WebUploader.Base.version;
                            obj.statusText = '';
                            obj.setStatus = function(){
                                var prevStatus = statusMap[this.id];
                                typeof text !== 'undefined' && (this.statusText = text);
                                if(status !== prevStatus){
                                    statusMap[this.id] = status;
                                    //文件状态设置为已完成
                                    uploader[index].trigger('statuschage',status,prevStatus);
                                }
                            }
                            addFile( obj, uploader[index], queue, inputname);
                            setState( 'ready' ,uploader[index],placeholder,queue,statusBar,hiFilePicker);
                            updateStatus('ready',info,fileCount,fileSize);
                        }
                    }
                });
            });
    	});

        // 当有文件添加进来时执行，负责view的创建
        function addFile( file,now_uploader,queue,inputname) {
            var $li = $( '<li id="' + file.id + '">' +
                    '<p class="title">' + file.name + '</p>' +
                    /*'<p class="imgWrap"></p>'+*/
                    '<input type="hidden" name="' + inputname + '" value="'+file.inputValue+'">' +
                    '<p class="progress"><span></span></p>' +
                    '</li>' ),

                $btns = $('<div class="file-panel">' +
                    '<span class="cancel">删除</span></div>').appendTo( $li ),
                $prgress = $li.find('p.progress span'),
                $wrap = $li.find( 'p.imgWrap' ),
                $info = $('<p class="error"></p>');
            $wrap.text( '预览中' );
            if(file.flog == true){
            	var img = $('<img src="'+file.ret+'">');
                $wrap.empty().append( img );
            }else{
            	now_uploader.makeThumb( file, function( error, src ) {
                    if ( error ) {
                        $wrap.text( '不能预览' );
                        return;
                    }

                    var img = $('<img src="'+src+'">');
                    $wrap.empty().append( img );
                });
            }

            percentages[ file.id ] = [ file.size, 0 ];
            file.rotation = 0;

            /*file.on('statuschange', function( cur, prev ) {
                if ( prev === 'progress' ) {
                    $prgress.hide().width(0);
                } else if ( prev === 'queued' ) {
                    $li.off( 'mouseenter mouseleave' );
                    $btns.remove();
                }

                // 成功
                if ( cur === 'error' || cur === 'invalid' ) {
                    console.log( file.statusText );
                    showError( file.statusText );
                    percentages[ file.id ][ 1 ] = 1;
                } else if ( cur === 'interrupt' ) {
                    showError( 'interrupt' );
                } else if ( cur === 'queued' ) {
                    percentages[ file.id ][ 1 ] = 0;
                } else if ( cur === 'progress' ) {
                    $info.remove();
                    $prgress.css('display', 'block');
                } else if ( cur === 'complete' ) {
                    $('<div class="file-panel">' +
                    '<span class="cancel">删除</span></div>').appendTo( $li );
                    $li.append( '<span class="success"></span>');
                }
                $li.removeClass( 'state-' + prev ).addClass( 'state-' + cur );
            });*/

            $li.on( 'mouseenter', function() {
                $btns.stop().animate({height: 30});
            });
            $li.on( 'mouseleave', function() {
                $btns.stop().animate({height: 0});
            });
            $btns.on( 'click', 'span', function() {
                var index = $(this).index(),
                    deg;
                switch ( index ) {
                    case 0:
                    	now_uploader.removeFile( file );
                        now_uploader.reset();
                        return;
                    case 1:
                        file.rotation += 90;
                        break;
                    case 2:
                        file.rotation -= 90;
                        break;
                }
                if ( supportTransition ) {
                    deg = 'rotate(' + file.rotation + 'deg)';
                    $wrap.css({
                        '-webkit-transform': deg,
                        '-mos-transform': deg,
                        '-o-transform': deg,
                        'transform': deg
                    });
                } else {
                    $wrap.css( 'filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation='+ (~~((file.rotation/90)%4 + 4)%4) +')');
                }
            });
            $li.appendTo(queue);
            //console.log(file);
        }

        // 负责view的销毁
        function removeFile( file ) {
            var $li = $('#'+file.id);
            delete percentages[ file.id ];
            $li.off().find('.file-panel').off().end().remove();
        }

        function setState( val, now_uploader,placeHolder,queue,statusBar,hiFilePicker) {
            switch (val) {
                case 'pedding':
                    placeHolder.removeClass( 'element-invisible' );
                    queue.parent().removeClass('filled');
                    queue.hide();
                    statusBar.addClass( 'element-invisible' );
                    now_uploader.refresh();
                    break;

                case 'ready':
                    placeHolder.addClass( 'element-invisible' );
                    hiFilePicker.removeClass( 'element-invisible');
                    queue.parent().addClass('filled');
                    queue.show();
                    statusBar.removeClass('element-invisible');
                    now_uploader.refresh();
                    break;
            }

        }

        function updateStatus(val,info,f_count,f_size) {
            var text = '';
            if ( val === 'ready' ) {
                text = '选中' + f_count + '张图片，共' +
                        WebUploader.formatSize( f_size ) + '。';
            }
            info.html( text );
        }

    });
