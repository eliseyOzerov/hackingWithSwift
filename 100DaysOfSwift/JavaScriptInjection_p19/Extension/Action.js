var Action = function() { }

Action.prototype = {
    
run: function(params) {
    params.completionFunction({
        "URL": document.URL,
        "title": document.title
    });
},
    
finalize: function(params) {
    var customJavaScript = params["customJavaScript"];
    eval(customJavaScript)
}
    
};

var ExtensionPreprocessingJS = new Action
