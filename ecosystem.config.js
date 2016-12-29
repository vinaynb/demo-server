module.exports = {
  /**
   * Application configuration section
   * http://pm2.keymetrics.io/docs/usage/application-declaration/
   */
  apps : [

    // First application
    {
      name      : "Server 1",
      script    : "server-1/index.js",
      env: {
        COMMON_VARIABLE: "true"
      },
      env_production : {
        NODE_ENV: "production"
      }
    },

    // Second application
    {
      name      : "Server 2",
      script    : "server-2/index.js"
    }
  ],

  /**
   * Deployment section
   * http://pm2.keymetrics.io/docs/usage/deployment/
   */
  deploy : {
    production : {
      key  : "/home/upc1/Desktop/ELK_Stack.pem",
      user : "ubuntu",
      host : "54.255.182.213",
      ref  : "origin/master",
      repo : "https://github.com/vinaynb/demo-server.git",
      path : "/home/ubuntu/Desktop/pm2Test",
      "pre-deploy"  : "sudo npm install -g pm2 ",
      "post-deploy" : "pm2 startOrRestart ecosystem.config.js --env production"
    },
    dev : {
      user : "node",
      host : "212.83.163.1",
      ref  : "origin/master",
      repo : "git@github.com:repo.git",
      path : "/var/www/development",
      "post-deploy" : "npm install && pm2 startOrRestart ecosystem.json --env dev",
      env  : {
        NODE_ENV: "dev"
      }
    }
  }
}
