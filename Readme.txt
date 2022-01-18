To use this package, just clone the repo into a home directory:

mkdir Terminal_Setup
git clone git@github.com:RWatson54/Terminal_Setup.git ~/Terminal_Setup/.

~/Terminal_Setup

Then copy out the files to where they'll be used:

cp ~/Terminal_Setup/.onthisday ~/.
cp ~/Terminal_Setup/.emacs ~/.
cp ~/Terminal_Setup/.bashrc ~/.

Once this is done, you can restart the terminal, and you should have the usual setup.

On any changes to the files, you can run:
  
updateTSRepo (which is conveniently defined in the .bashrc file)

to copy the changes into the ~/Terminal_Setup directory

Then run:

git add --all 
git commit -m "......"
git push origin master

to push the changes up to github and make them available to other machines

