Hello! Welcome to Access Control through smart contracts and the ethereum blockchain.

First of, I apologize for the difficult nature of testing/using this project. The nature of working with the blockchain, and not being able to simply demonstrate the project to you in person, makes this rather challenging. With that said, there are two ways you could test this. Since I can't exactly turn in a functional private blockchain network (as it highly dependents on your machines setup, installed tools, configuration, etc), you can either try to

A) *RECOMMENDED* Just as effective as building your own blockchain network (in my opinion) would be to use Remix online IDE to test the smart contract interactions. The included interface.html is extremely simple, and was really just for ease of testing use within my local network (as opposed to repeatedly running command line commands). That would look like (video also included, may be easier to follow):

	1) Go to https://remix.ethereum.org. There are 5 included smart contracts, paste each of them into their own .sol file using the text editor attached, with the same names (Authority.sol, Device.sol, Lock.sol, Light.sol, Thermometer.sol). You can ignore Migrations.sol.
	2) Click on home. Click on Solidity as the environmment. More menu options should appear.
	3) Click the compiler icon (right below the file icon in the menu on the left of the screen). Make sure you are viewing the Authority.sol file. Click compile Authority.sol.
	4) Click the deploy and run transactions menu (just below the compiler icon in the menu on the left of the screen). Deploy Authority.sol.
	5) A clickable (openable) drop down menu now appears. Here, you can interact with the smart contract to add devices, make requests against the authority, test authentication of the user, adding users, or whatever else you wish. You can switch users by scrolling up on this page and selecting a different account. I have demonstrated a couple of tests in the included video.

	Note: A type of 0 is a lock, 1 is a light, and 2 is a thermostat (useful for inputting test data, see video for clarity).


B) Duplicate my setup process exactly. I spent several weeks getting this process down, and in that time boiled the process down to as concise and clear as I possibly could, so this is hypothetically a fine option, but the process might be finnicky based on the nature of hosting a local blockchain. I really did this portion of the project more as a proof of concept, since it was enormously difficult and time consuming to figure it out. This method is also only possible in such few steps because I wrote tons of configuration for it ahead of time, all of which is included in the tarball.

	1) Run "npm install -g truffle ganache-cli live-server" at the commandline to install the necessary tools.
	2) Navigate to the following location in the included directory: /ethac/truffle
	3) Run "truffle compile"
	4) In a seperate terminal window, run "ganache-cli -p 8545". It will print out a list of Available Accounts and Private Keys. Copy a few of the private keys (however many you want to experiment with). Save this in a note somewhere.
	5) In the first terminal window, run "truffle migrate -network development". Copy the output contract address.
	6) In the interface.html file, replace the contractAddress variable with the previously copied address from running truffle migrate.
	7) Install MetaMask chrome extension. In the extension, click Import Account and paste the private key you copied and stored from running ganache.
	8) cd into the src folder, and run the command "live-server". This should boot up the javascript application. MetaMask should prompt you to connect. Go ahead and connect.
	9) Experiment with the live-server using the built in forms and buttons. I know this web application is a little buggy, and very ugly, but it was kind-of a late extension to the existing project. Certainly, it wasn't part of the original, core functionality. Note that to switch accounts you'll need to import another of the ganache generated accounts into MetaMask, and switch accounts through the extension.

	*Bug note*: There is a notable web3js bug here that sometimes prevents calls from going through to the ethereum blockchain.
	It looks like: 
	"Uncaught (in promise) Error: Returned values aren't valid, did it run Out of Gas?"
	But occurs when there is plenty of gas (and no return types).
	It's discussed here: https://ethereum.stackexchange.com/questions/61073/uncaught-error-returned-values-arent-valid-did-it-run-out-of-gas
	and here: https://github.com/ethereum/web3.js/issues/1916#issuecomment-427398031
	I was able to fix this by downgrading to web3js version 1.0.0-beta33.

	Like I said, I would just recommend testing with Remix.