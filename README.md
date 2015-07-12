## HubStub

This project is an example Pivot project from previous Turing students.
It will be used for the ScaleUp project and various other tutorials in
the curriculum.

Original project specifications are available here:
http://tutorials.jumpstartlab.com/projects/the_pivot.html

## Using this Code Base for Your ScaleUp

1. Clone the project
2. Create a new repository on github
3. Add that repository as your origin (`git remote rm origin` ; `git
   remote add origin my-new-git-remote`)
4. (Optional) If you want to be able to easily pull future updates from
this repository, you can add it back as another remote (e.g. upstream):
`git remote add upstream https://github.com/turingschool-examples/HubStub.git`

Remember, you will be required to re-deploy the project to your own
heroku instance.

## Notes

To get this to run locally, you need to run the following:

    brew install imagemagick

### Here's what you'll need to do after pulling to get it working on heroku
* `bundle install`
* `git push heroku master`
* `heroku pg:reset`
* `heroku run rake db:schema:load db:seed`
* `heroku open` and look at all the glorious menu/item images

#### Contributor Log

* Scott Crawford: https://github.com/ScottCrawford03
* Bhargavi Satpathy: https://github.com/bhargavisatpathy
* Krista Nelson: https://github.com/KristaANelson
* Nathan Owsiany: https://github.com/ndwhtlssthr

# The-Scale-Up
