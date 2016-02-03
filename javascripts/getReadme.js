// Choose branch based on query string
var query = window.location.search;
if (query) {
    var branch = query.replace("?", "");
} else {
    var branch = "master";
}
 
// Load readme content
$.ajax({
    url: "https://github.com/EduardoGR/Understanding-Monads/"+branch+"/readme.md",
    dataType: 'text',
    success: function(data) {
 
        // Convert readme from markdown to html
        var converter = new Markdown.Converter();
 
        // Show html
        $(".wrapper").html(converter.makeHtml(data));
 
    }
});
