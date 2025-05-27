  if ('NodeList' in window && !NodeList.prototype.forEach) {
    NodeList.prototype.forEach = function (callback, thisArg) {
      thisArg = thisArg || window;
      for (var i = 0; i < this.length; i++) {
        callback.call(thisArg, this[i], i, this);
      }
    };
  }
  
function cssPreloadLinks()
{
    var links = document.getElementsByTagName('link');
    for (var i = 0; i < links.length; i++) {
        var link = links[i];
        // qualify links to those with rel=preload and as=style attrs
        if (link.rel === 'preload' && link.getAttribute('as') === 'style') {
            // prevent re-running on link
            link.setAttribute('rel', 'stylesheet');
        }
    }
}

document.addEventListener('DOMContentLoaded', function(){
	cssPreloadLinks()
});
cssPreloadLinks();