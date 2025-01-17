﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="imageuploasd.aspx.cs" Inherits="imageuploasd" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">

    <link rel="stylesheet" href="css/html5demos.css">
    <script src="js/h5utils.js"></script>
</head>
<body>
    <section id="wrapper">

        <style>
            #holder {
                border: 10px dashed #ccc;
                width: 100px;
                height: 100px;
                margin: 20px auto;
            }

                #holder.hover {
                    border: 10px dashed #333;
                }
        </style>
        <article>
            <div id="holder"></div>
            <p id="status"></p>
            <p>Drag an image from your desktop on to the drop zone above to see the browser read the contents of the file and use it as the background - without uploading the file to any servers.</p>
        </article>
        <script>
            var holder = document.getElementById('holder'),
                state = document.getElementById('status');

            if (typeof window.FileReader === 'undefined') {
                state.className = 'fail';
            } else {
                state.className = 'success';
                state.innerHTML = 'File API & FileReader available';
            }

            holder.ondragover = function () { this.className = 'hover'; return false; };
            holder.ondragend = function () { this.className = ''; return false; };
            holder.ondrop = function (e) {
                this.className = '';
                e.preventDefault();

                var file = e.dataTransfer.files[0],
                    reader = new FileReader();
                reader.onload = function (event) {
                    console.log(event.target);
                    holder.style.background = 'url(' + event.target.result + ') no-repeat center';
                };
                console.log(file);
                reader.readAsDataURL(file);

                return false;
            };
        </script>
    </section>
</body>
</html>