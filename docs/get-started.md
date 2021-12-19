Initialize a PETAL stack app
===

About the Elixir's PETAL (Phoenix, Ecto, Tailwind, Alpine, LiveView) stack : [an article by Lars Wikman (from 13 of Junuary 2021)](https://changelog.com/posts/petal-the-end-to-end-web-stack) on changelog.com.



Obviously, before starting this Elixir project, mind to install Elixir:
- [Through the MacOS (or Linux) package manager, *Brew*](https://brew.sh/) : `brew install elixir`
- [Through the Windows package manager, *Chocolatey*](https://chocolatey.org/) : `choco install elixir` or `cinst elixir`
- For all others OS (especially Linux based OS), please take a look to [the Elixir documentation](https://elixir-lang.org/install.html).

Next, install its depedencies : 
- [The package manager, *Hex*](https://hex.pm/) : `mix local.hex`;
- [The Phoenix framework](https://www.phoenixframework.org/), `mix archive.install hex phx_new`.

We will also use (and need) *Yarn* for the front, *PostGreSQL* for the database, *Docker* to containerize our app. 



## Initialize the project

Let's init this project and document it. For some help, you can read [this article by Washington Botelhov (from 27th of May 2021)](https://www.wbotelhos.com/crud-in-5-minutes-with-phoenix-and-elixir) on its personal website.

0. Go in the root folder where you want to create your project.
1. Create a new Phoenix and LiveView App, named `ride`: 
```shell
mix phx.new ride
# Go into your project
cd ride
```
2. Initialize documentation and choose your license ([click here if you need help](https://choosealicense.com/)), I will use GNU GLP v3 here:
```shell
# Create a docs folder + an images folder inside it
mkdir docs docs/imgs
# Create basic readme with the project name : Ride
echo "Ride
===" >> README.md
# Init the license file
touch LICENSE
```
3. Add Tailwind to the project. For more information, don't hesitate to [read this documentation](https://pragmaticstudio.com/tutorials/adding-tailwind-css-to-phoenix) or to read [official Tailwind documentation](https://v1.tailwindcss.com/docs/installation).
  1. Install Tailwind :
     ```shell
cd assets && yarn add tailwindcss postcss autoprefixer --save-dev
     ```
  2. Add Tailwind as a PostCSS Plugin (in `postcss.config.js` under `assets/`) : 
     ```shell
echo "module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  }
}
" >> postcss.config.js
     ```
  3. Configure Tailwind for Phoenix :
    ```shell
# Init tailwind modules
npx tailwindcss init
# Replace assets/tailwind.config.js content
echo "module.exports = {
  content: [
    './js/**/*.js',
    '../lib/*_web/**/*.*ex'
  ],
  theme: {},
  variants: {},
  plugins: []
};" > tailwind.config.js
    ```
  4. In `assets/css/app.css`, add the following code after imports:
  ```css
@import ...

@tailwind base;
@tailwind components;
@tailwind utilities;
...
  ```
  5. Since we add our own CSS build pipeline (PostCSS), mind to remove `import "../css/app.css"` from `assets/js/app.js`.
  6. Add a Watcher to kick off the CSS build process anytime relevant changes are made during development. In `config/dev.exs` add a npx watcher to the watchers list:
  ```elixir
  watchers: [
  esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]},
  npx: [
    "tailwindcss",
    "--input=css/app.css",
    "--output=../priv/static/assets/app.css",
    "--postcss",
    "--watch",
    cd: Path.expand("../assets", __DIR__)
    ]
  ]
  ```
  7. Back to main project folder 
  ```shell
  cd ..
  ```
4. Add DaisyUI ([doc](https://daisyui.com/docs/install))
  1. Add DaisyUI to the project
  ```shell
  cd assets & yarn add daisyui
  ```
  2. Then add daisyUI to your tailwind.config.js
  ```js
module.exports = {

  plugins: [
    require('daisyui'),
  ],

}
  ```
5. Building CSS in Production
  1. Create a deploy script in the assets/package.json:
    ```json
{
  "scripts": {
    "deploy": "NODE_ENV=production tailwindcss --postcss --minify --input=css/app.css --output=../priv/static/assets/app.css"
  },
  "dependencies": {
    // ...
  }
}
    ```
  2. Then we want to run the deploy script as part of the mix assets.deploy task. So open mix.exs and find the "assets.deploy" alias in the aliases function.
  ```elixir
"assets.deploy": [
  "cmd --cd assets npm run deploy",
  "esbuild default --minify",
  "phx.digest"
]
  ```
6. Dockerize a PostGre DB
```shell
echo "version: \"3.8\"

services:
  database:
    environment:
      POSTGRES_HOST_AUTH_METHOD: trust

    image: postgres:14-alpine

    ports:
      - 5432:5432
" >> docker-compose.yml

docker-compose up -d
```
7. Install dependencies with `mix deps.get`
8. Create and migrate your database with `mix ecto.setup`
9. Start Phoenix endpoint with `mix phx.server` (or inside IEx with `iex -S mix phx.server`). Yeah, it's really not beautiful for the moment but we will change all of that after !
10. Initialize a git repository and let's push all of that:
```shell
git init
git add .
git commit -m "Initial commit, initialize PETAL app

- Create an Elixir's app with the Phoenix - LiveView framework
- Add basic dependencies (especially Ecto)
- Create base documentation
- Add a license
- Create docker-compose for the database
- Add Tailwind and DaisyUI to the project
- Initialize the front
"
git branch -M main
git remote add origin git@github.com:Thibault-Santonja/Ride.git
git push -u origin main
```


---

Author : Thibault *Santonja* <br/>
*2021*