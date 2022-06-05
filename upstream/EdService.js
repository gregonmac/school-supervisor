const axios = require("axios");
class User {
  login;
  pwd;
  constructor(login, pwd) {
    this.login = login;
    this.pwd = pwd;
  }
}

class Student {
  id;
  constructor(id) {
    this.id = id;
  }
}

class EdService {
  edUrl;
  user;
  student;
  constructor(url, login, pwd, studentId) {
    this.edUrl = url;
    this.user = new User(login, pwd);
    this.student = new Student(studentId);
  }

  async auth() {
    try {
      const qs = require("qs");
      const json = qs.stringify({
        data: JSON.stringify({
          identifiant: this.user.login,
          motdepasse: this.user.pwd,
          isReLogin: "false",
        }),
      });
      const { data } = await axios.post(
        this.edUrl+'/login.awp',

        json,
        {
          headers: { "Content-Type": "application/x-www-form-urlencoded" },
        }
      );

      return data;
    } catch (error) {
      console.log(error);
      return error;
    }
  }
    
    async read(token) {
        
        try {
      const qs = require("qs");
      const json = qs.stringify({
        data: JSON.stringify({
          token: token,
        }),
      });
      const { data } = await axios.post(
        this.edUrl+`/eleves/${this.student.id}/notes.awp?verbe=get&`,

        json,
        {
          headers: { "Content-Type": "application/x-www-form-urlencoded" },
        }
      );

      return data;
    } catch (error) {
      console.log(error);
      return error;
    }
    }
}

module.exports = EdService;
