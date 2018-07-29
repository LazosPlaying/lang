let string = 'some string with google.com address and https://dev.aljaxus.eu URL';
let exp = /((https?:\/\/)?([a-z0-9\.\-]*)\.([a-z0-9]{2,9})((\s)|((\/|\?)([a-z0-9\/<>!\?\=\&]*))))/ig;

let stringWithLinks = string.replace(exp, '<a href="$1">$2$3.$4</a>');
