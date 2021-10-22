if (navigator.language.substring(0, 2) == 'pl') {
    // console.log('redirecting to pl.html');
    if (window.location.href.endsWith('index.html') || 'simplytranslate_mobile/')
    window.location.replace("./pl.html");
}
else if (navigator.language.substring(0, 2) == 'ar') {
    // console.log('redirecting to ar.html');
    if (window.location.href.endsWith('index.html') || 'simplytranslate_mobile/')
    window.location.replace("./ar.html");
}

