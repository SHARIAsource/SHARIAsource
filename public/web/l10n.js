/**
 * Copyright (c) 2011-2013 Fabien Cazenave, Mozilla.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */
"use strict"
document.webL10n=function(n,e,t){function r(){return e.querySelectorAll('link[type="application/l10n"]')}function o(){var n=e.querySelector('script[type="application/l10n"]')
return n?JSON.parse(n.innerHTML):null}function i(n){return n?n.querySelectorAll("*[data-l10n-id]"):[]}function u(n){if(!n)return{}
var e=n.getAttribute("data-l10n-id"),t=n.getAttribute("data-l10n-args"),r={}
if(t)try{r=JSON.parse(t)}catch(n){console.warn("could not parse arguments for #"+e)}return{id:e,args:r}}function a(n){var t=e.createEvent("Event")
t.initEvent("localized",!0,!1),t.language=n,e.dispatchEvent(t)}function f(n,e,t){e=e||function(n){},t=t||function(){}
var r=new XMLHttpRequest
r.open("GET",n,E),r.overrideMimeType&&r.overrideMimeType("text/plain; charset=utf-8"),r.onreadystatechange=function(){4==r.readyState&&(200==r.status||0===r.status?e(r.responseText):t())},r.onerror=t,r.ontimeout=t
try{r.send(null)}catch(n){t()}}function c(n,e,t,r){function o(n){return n.lastIndexOf("\\")<0?n:n.replace(/\\\\/g,"\\").replace(/\\n/g,"\n").replace(/\\r/g,"\r").replace(/\\t/g,"\t").replace(/\\b/g,"\b").replace(/\\f/g,"\f").replace(/\\{/g,"{").replace(/\\}/g,"}").replace(/\\"/g,'"').replace(/\\'/g,"'")}function i(n,t){function r(n,t,r){function f(){for(;;){if(!g.length)return void r()
var n=g.shift()
if(!l.test(n)){if(t){if(w=s.exec(n)){v=w[1].toLowerCase(),m="*"!==v&&v!==e&&v!==p
continue}if(m)continue
if(w=d.exec(n))return void i(u+w[1],f)}var c=n.match(h)
c&&3==c.length&&(a[c[1]]=o(c[2]))}}}var g=n.replace(c,"").split(/[\r\n]+/),v="*",p=e.split("-",1)[0],m=!1,w=""
f()}function i(n,e){f(n,function(n){r(n,!1,e)},function(){console.warn(n+" not found."),e()})}var a={},c=/^\s*|\s*$/,l=/^\s*#|^\s*$/,s=/^\s*\[(.*)\]\s*$/,d=/^\s*@import\s+url\((.*)\)\s*$/i,h=/^([^=\s]*)\s*=\s*(.+)$/
r(n,!0,function(){t(a)})}var u=n.replace(/[^\/]*$/,"")||"./"
f(n,function(n){b+=n,i(n,function(n){for(var e in n){var r,o,i=e.lastIndexOf(".")
i>0?(r=e.substring(0,i),o=e.substr(i+1)):(r=e,o=k),y[r]||(y[r]={}),y[r][o]=n[e]}t&&t()})},r)}function l(n,e){function t(n){var e=n.href
this.load=function(n,t){c(e,n,t,function(){console.warn(e+" not found."),console.warn('"'+n+'" resource not found'),z="",t()})}}n&&(n=n.toLowerCase()),e=e||function(){},s(),z=n
var i=r(),u=i.length
if(0===u){var f=o()
if(f&&f.locales&&f.default_locale){if(console.log("using the embedded JSON directory, early way out"),!(y=f.locales[n])){var l=f.default_locale.toLowerCase()
for(var d in f.locales){if((d=d.toLowerCase())===n){y=f.locales[n]
break}d===l&&(y=f.locales[l])}}e()}else console.log("no resource to load, early way out")
return a(n),void(L="complete")}var h=null,g=0
h=function(){++g>=u&&(e(),a(n),L="complete")}
for(var v=0;v<u;v++){new t(i[v]).load(n,h)}}function s(){y={},b="",z=""}function d(n){function e(n,e){return-1!==e.indexOf(n)}function t(n,e,t){return e<=n&&n<=t}var r={af:3,ak:4,am:4,ar:1,asa:3,az:0,be:11,bem:3,bez:3,bg:3,bh:4,bm:0,bn:3,bo:0,br:20,brx:3,bs:11,ca:3,cgg:3,chr:3,cs:12,cy:17,da:3,de:3,dv:3,dz:0,ee:3,el:3,en:3,eo:3,es:3,et:3,eu:3,fa:0,ff:5,fi:3,fil:4,fo:3,fr:5,fur:3,fy:3,ga:8,gd:24,gl:3,gsw:3,gu:3,guw:4,gv:23,ha:3,haw:3,he:2,hi:4,hr:11,hu:0,id:0,ig:0,ii:0,is:3,it:3,iu:7,ja:0,jmc:3,jv:0,ka:0,kab:5,kaj:3,kcg:3,kde:0,kea:0,kk:3,kl:3,km:0,kn:0,ko:0,ksb:3,ksh:21,ku:3,kw:7,lag:18,lb:3,lg:3,ln:4,lo:0,lt:10,lv:6,mas:3,mg:4,mk:16,ml:3,mn:3,mo:9,mr:3,ms:0,mt:15,my:0,nah:3,naq:7,nb:3,nd:3,ne:3,nl:3,nn:3,no:3,nr:3,nso:4,ny:3,nyn:3,om:3,or:3,pa:3,pap:3,pl:13,ps:3,pt:3,rm:3,ro:9,rof:3,ru:11,rwk:3,sah:0,saq:3,se:7,seh:3,ses:0,sg:0,sh:11,shi:19,sk:12,sl:14,sma:7,smi:7,smj:7,smn:7,sms:7,sn:3,so:3,sq:3,sr:11,ss:3,ssy:3,st:3,sv:3,sw:3,syr:3,ta:3,te:3,teo:3,th:0,ti:4,tig:3,tk:3,tl:4,tn:3,to:0,tr:0,ts:3,tzm:22,uk:11,ur:3,ve:3,vi:0,vun:3,wa:4,wae:3,wo:0,xh:3,xog:3,yo:0,zh:0,zu:3},o={0:function(n){return"other"},1:function(n){return t(n%100,3,10)?"few":0===n?"zero":t(n%100,11,99)?"many":2==n?"two":1==n?"one":"other"},2:function(n){return 0!==n&&n%10==0?"many":2==n?"two":1==n?"one":"other"},3:function(n){return 1==n?"one":"other"},4:function(n){return t(n,0,1)?"one":"other"},5:function(n){return t(n,0,2)&&2!=n?"one":"other"},6:function(n){return 0===n?"zero":n%10==1&&n%100!=11?"one":"other"},7:function(n){return 2==n?"two":1==n?"one":"other"},8:function(n){return t(n,3,6)?"few":t(n,7,10)?"many":2==n?"two":1==n?"one":"other"},9:function(n){return 0===n||1!=n&&t(n%100,1,19)?"few":1==n?"one":"other"},10:function(n){return t(n%10,2,9)&&!t(n%100,11,19)?"few":n%10!=1||t(n%100,11,19)?"other":"one"},11:function(n){return t(n%10,2,4)&&!t(n%100,12,14)?"few":n%10==0||t(n%10,5,9)||t(n%100,11,14)?"many":n%10==1&&n%100!=11?"one":"other"},12:function(n){return t(n,2,4)?"few":1==n?"one":"other"},13:function(n){return t(n%10,2,4)&&!t(n%100,12,14)?"few":1!=n&&t(n%10,0,1)||t(n%10,5,9)||t(n%100,12,14)?"many":1==n?"one":"other"},14:function(n){return t(n%100,3,4)?"few":n%100==2?"two":n%100==1?"one":"other"},15:function(n){return 0===n||t(n%100,2,10)?"few":t(n%100,11,19)?"many":1==n?"one":"other"},16:function(n){return n%10==1&&11!=n?"one":"other"},17:function(n){return 3==n?"few":0===n?"zero":6==n?"many":2==n?"two":1==n?"one":"other"},18:function(n){return 0===n?"zero":t(n,0,2)&&0!==n&&2!=n?"one":"other"},19:function(n){return t(n,2,10)?"few":t(n,0,1)?"one":"other"},20:function(n){return!t(n%10,3,4)&&n%10!=9||t(n%100,10,19)||t(n%100,70,79)||t(n%100,90,99)?n%1e6==0&&0!==n?"many":n%10!=2||e(n%100,[12,72,92])?n%10!=1||e(n%100,[11,71,91])?"other":"one":"two":"few"},21:function(n){return 0===n?"zero":1==n?"one":"other"},22:function(n){return t(n,0,1)||t(n,11,99)?"one":"other"},23:function(n){return t(n%10,1,2)||n%20==0?"one":"other"},24:function(n){return t(n,3,10)||t(n,13,19)?"few":e(n,[2,12])?"two":e(n,[1,11])?"one":"other"}},i=r[n.replace(/-.*$/,"")]
return i in o?o[i]:(console.warn("plural form unknown for ["+n+"]"),function(){return"other"})}function h(n,e,t){var r=y[n]
if(!r){if(console.warn("#"+n+" is undefined."),!t)return null
r=t}var o={}
for(var i in r){var u=r[i]
u=g(u,e,n,i),u=v(u,e,n),o[i]=u}return o}function g(n,e,t,r){var o=/\{\[\s*([a-zA-Z]+)\(([a-zA-Z]+)\)\s*\]\}/,i=o.exec(n)
if(!i||!i.length)return n
var u,a=i[1],f=i[2]
if(e&&f in e?u=e[f]:f in y&&(u=y[f]),a in x){n=(0,x[a])(n,u,t,r)}return n}function v(n,e,t){var r=/\{\{\s*(.+?)\s*\}\}/g
return n.replace(r,function(n,r){return e&&r in e?e[r]:r in y?y[r]:(console.log("argument {{"+r+"}} for #"+t+" is undefined."),n)})}function p(n){var t=u(n)
if(t.id){var r=h(t.id,t.args)
if(!r)return void console.warn("#"+t.id+" is undefined.")
if(r[k]){if(0===m(n))n[k]=r[k]
else{for(var o=n.childNodes,i=!1,a=0,f=o.length;a<f;a++)3===o[a].nodeType&&/\S/.test(o[a].nodeValue)&&(i?o[a].nodeValue="":(o[a].nodeValue=r[k],i=!0))
if(!i){var c=e.createTextNode(r[k])
n.insertBefore(c,n.firstChild)}}delete r[k]}for(var l in r)n[l]=r[l]}}function m(n){if(n.children)return n.children.length
if(void 0!==n.childElementCount)return n.childElementCount
for(var e=0,t=0;t<n.childNodes.length;t++)e+=1===n.nodeType?1:0
return e}function w(n){n=n||e.documentElement
for(var t=i(n),r=t.length,o=0;o<r;o++)p(t[o])
p(n)}var y={},b="",k="textContent",z="",x={},L="loading",E=!0
return x.plural=function(n,e,t,r){var o=parseFloat(e)
if(isNaN(o))return n
if(r!=k)return n
x._pluralRules||(x._pluralRules=d(z))
var i="["+x._pluralRules(o)+"]"
return 0===o&&t+"[zero]"in y?n=y[t+"[zero]"][r]:1==o&&t+"[one]"in y?n=y[t+"[one]"][r]:2==o&&t+"[two]"in y?n=y[t+"[two]"][r]:t+i in y?n=y[t+i][r]:t+"[other]"in y&&(n=y[t+"[other]"][r]),n},{get:function(n,e,t){var r=n.lastIndexOf("."),o=k
r>0&&(o=n.substr(r+1),n=n.substring(0,r))
var i
t&&(i={},i[o]=t)
var u=h(n,e,i)
return u&&o in u?u[o]:"{{"+n+"}}"},getData:function(){return y},getText:function(){return b},getLanguage:function(){return z},setLanguage:function(n,e){l(n,function(){e&&e(),w()})},getDirection:function(){var n=["ar","he","fa","ps","ur"],e=z.split("-",1)[0]
return n.indexOf(e)>=0?"rtl":"ltr"},translate:w,getReadyState:function(){return L},ready:function(t){t&&("complete"==L||"interactive"==L?n.setTimeout(function(){t()}):e.addEventListener&&e.addEventListener("localized",function n(){e.removeEventListener("localized",n),t()}))}}}(window,document)
