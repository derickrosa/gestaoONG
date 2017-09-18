/**
 * Created by hyago on 08/09/17.
 */
String.prototype.format = function () {
    var content = this;
    for (var i = 0; i < arguments.length; i++) {
        var target = '{' + i + '}';
        content = content.split(target).join(String(arguments[i]))
        content = content.replace("{}", String(arguments[i]));
    }
    return content;
};

String.prototype.contains = function (substring) {
    return this.indexOf(substring) !== -1;
};