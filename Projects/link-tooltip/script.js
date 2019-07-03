(function(d, b) {
   b.tabs.insertCSS(null, {
      cssOrigin: 'user',
      file: '/styles.css'
   }).then(a => {
      console.log(a);
   }).catch(err => {
      console.log(err);
   });
})(document, browser);
