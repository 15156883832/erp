(function(ns){    
        function Scroll(element){  
            
            
            var content = document.createElement("div");  
            var container = document.createElement("div");  
            var _this =this;  
            var cssText = "position: absolute; visibility:hidden; left:0; white-space:nowrap;";  
            var maxWidth = 690;
            this.element = element;
            this.contentWidth = 0;  
            this.stop = false;  
                
            content.innerHTML = element.innerHTML;  
           
            //获取元素真实宽度  
            content.style.cssText = cssText;  
            element.appendChild(content);  
            this.contentWidth = content.offsetWidth;  
            
            
            content.style.cssText= "float:left; padding: 0 5px;";
            container.appendChild(content);  
            if(this.contentWidth > maxWidth){
            	container.style.cssText ="width: " + (this.contentWidth*2+21) + "px;overflow:hidden";
            	container.appendChild(content.cloneNode(true));  
            }else{
            	container.style.cssText ="width: " + (this.contentWidth+11) + "px;overflow:hidden";
            }
            
           	element.innerHTML = "";  
            element.appendChild(container);  
                
            container.onmouseover = function(e){  
                clearInterval(_this.timer);  
            };  
                
            container.onmouseout = function(e){  
                _this.timer = setInterval(function(){   
                    _this.run();  
                },20);                    
            };  
            _this.timer = setInterval(function(){   
                _this.run();  
            }, 30);  
        }  
            
        Scroll.prototype = {  
            run: function(){  
                var _this = this;  
                var element = _this.element;  
                    
                element.scrollLeft = element.scrollLeft + 1;  
                    
                if(element.scrollLeft >=  this.contentWidth ) {  
                        element.scrollLeft = 0;  
                }  
            }  
        };  
        
    ns.Scroll = Scroll;   
}(window));  