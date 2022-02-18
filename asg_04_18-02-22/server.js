// Step1 : require http
const http=require('http');
// Step2 : require fs
const fs=require('fs');
// step3 : const port
const port=3000;
// step4 : createServer
        //    1.Request url =>http://localhost:3000/=> index.html
        //    2.Request url =>http://localhost:3000/css/style.css=>/css/style.css  
// step5 : listen(port,()={})        
http.createServer((req,resp)=>{
    const URL=req.url;
    switch(URL){
        case '/':
                fs.readFile(__dirname+'/index.html',(err,data)=>{
                        resp.setHeader('Content-Type','text/html');
                        if(err){
                            resp.write(err);
                        }else{
                            resp.write(data);
                        }
                        resp.end();    
                });
            break;
        case '/css/style.css':
            fs.readFile(__dirname+'/css/style.css',(err,data)=>{
                resp.setHeader('Content-Type','text/css');
                if(err){
                    resp.write(err);
                }else{
                    resp.write(data);
                }
                resp.end();    
        });
            break;
    
    
        default:
                resp.write(URL+" File not found ");
                resp.end;
            break;    
    }


}).listen(port,()=>{
    console.log(`http://localhost:${port} started`);

});