# Contributing

When contributing to this repository, please first make an issue describing the changes your PR will 
bring to the project. Thanks for reading this document and thinking about helping us build this project. 

Please note we have a code of conduct, please follow it in all your interactions with the project.

## Pull Request Process

1. Make your changes on a branch, corresponding to an issue. Make sure the project builds and is functional.
  <INSERT TESTING CI>
3. Update the README.md with details of changes to the interface, this includes new environment 
   variables, exposed ports, useful file locations and container parameters.
4. You may merge the Pull Request in once you have the sign-off of another developer.

## Code of Conduct

### Our Pledge

In the interest of fostering an open and welcoming environment, we as
contributors and maintainers pledge to making participation in our project and
our community a harassment-free experience for everyone, regardless of age, body
size, disability, ethnicity, gender identity and expression, level of experience,
nationality, personal appearance, race, religion, or sexual identity and
orientation.

### Our Standards

Examples of behavior that contributes to creating a positive environment
include:

* Using welcoming and inclusive language
* Being respectful of differing viewpoints and experiences
* Gracefully accepting constructive criticism
* Focusing on what is best for the community
* Showing empathy towards other community members

Examples of unacceptable behavior by participants include:

* The use of sexualized language or imagery and unwelcome sexual attention or
advances
* Trolling, insulting/derogatory comments, and personal or political attacks
* Public or private harassment
* Publishing others' private information, such as a physical or electronic
  address, without explicit permission
* Other conduct which could reasonably be considered inappropriate in a
  professional setting

# Coding conventions
Start reading our code and you'll get the hang of it. We optimize for readability:


  * We indent using two spaces (soft tabs)
  * We avoid logic in views, putting HTML generators into helpers
  * We ALWAYS put spaces after list items and method parameters (`[1, 2, 3]`, not `[1,2,3]`), around operators (`x += 1`, not `x+=1`), and around hash arrows.
  * This is open source software. Consider the people who will read your code, and make it look nice for them. It's sort of like driving a car: Perhaps you love doing donuts when you're alone, but with passengers the goal is to make the ride as smooth as possible.
  * So that we can consistently serve images from the CDN, always use image_path or image_tag when referring to images. Never prepend "/images/" when using image_path or image_tag.
  * Also for the CDN, always use cwd-relative paths rather than root-relative paths in image URLs in any CSS. So instead of url('/images/blah.gif'), use url('../images/blah.gif').
 
Thanks, Molly Clare, Sierra Johnson, Vincent Futrell, Andrew Stender
