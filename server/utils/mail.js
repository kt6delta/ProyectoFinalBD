import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const nodemailer = require('nodemailer');
const fs = require('fs');

async function sendEmail(email, username, token) {
    const msg_title = "¡Verifica tu dirección de correo electrónico!";
    const url = process.env.BACKEND_URL+"/login/auth/"+token;
    let msg_body = fs.readFileSync('utils/correo.html',{encoding:'utf8'});
    msg_body = msg_body.replace("{{username}}", username).replace("{{username}}", username);
    msg_body = msg_body.replace("{{url}}", url).replace("{{url}}", url).replace("{{url}}", url);


    let transporter = nodemailer.createTransport({
        host: process.env.MAIL_SERVER,
        port: process.env.MAIL_PORT,
        secure: process.env.MAIL_USE_TLS,
        auth: {
            user: process.env.MAIL_USERNAME,
            pass: process.env.MAIL_PASSWORD
        }
    });

    let mailOptions = {
        from: process.env.MAIL_USERNAME,
        to: email,
        subject: msg_title,
        html: msg_body
    };

    try {
        await transporter.sendMail(mailOptions);
        console.log("email sent");
        return "email sent";
    } catch (e) {
        console.log(`the email was not sent ${e}`);
        return `the email was not sent ${e}`;
    }
}

async function sendEmailRecuperar(email, username, token) {
    const msg_title = "¡Cambio de Contraseña!";
    const url = process.env.BACKEND_URL+"/recuperar/"+token;
    let msg_body = fs.readFileSync('utils/recuperar.html',{encoding:'utf8'});
    msg_body = msg_body.replace("{{username}}", username).replace("{{username}}", username);
    msg_body = msg_body.replace("{{url}}", url).replace("{{url}}", url).replace("{{url}}", url);


    let transporter = nodemailer.createTransport({
        host: process.env.MAIL_SERVER,
        port: process.env.MAIL_PORT,
        secure: process.env.MAIL_USE_TLS,
        auth: {
            user: process.env.MAIL_USERNAME,
            pass: process.env.MAIL_PASSWORD
        }
    });

    let mailOptions = {
        from: process.env.MAIL_USERNAME,
        to: email,
        subject: msg_title,
        html: msg_body
    };

    try {
        await transporter.sendMail(mailOptions);
        console.log("email sent");
        return "email sent";
    } catch (e) {
        console.log(`the email was not sent ${e}`);
        return `the email was not sent ${e}`;
    }
}

export default {
    sendEmail,
    sendEmailRecuperar
}