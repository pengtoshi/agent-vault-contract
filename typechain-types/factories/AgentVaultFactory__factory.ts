/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import type {
  AgentVaultFactory,
  AgentVaultFactoryInterface,
} from "../AgentVaultFactory";

const _abi = [
  {
    inputs: [],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "target",
        type: "address",
      },
    ],
    name: "AddressEmptyCode",
    type: "error",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "implementation",
        type: "address",
      },
    ],
    name: "ERC1967InvalidImplementation",
    type: "error",
  },
  {
    inputs: [],
    name: "ERC1967NonPayable",
    type: "error",
  },
  {
    inputs: [],
    name: "FailedInnerCall",
    type: "error",
  },
  {
    inputs: [],
    name: "InvalidInitialization",
    type: "error",
  },
  {
    inputs: [],
    name: "NotInitializing",
    type: "error",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "owner",
        type: "address",
      },
    ],
    name: "OwnableInvalidOwner",
    type: "error",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "account",
        type: "address",
      },
    ],
    name: "OwnableUnauthorizedAccount",
    type: "error",
  },
  {
    inputs: [],
    name: "UUPSUnauthorizedCallContext",
    type: "error",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "slot",
        type: "bytes32",
      },
    ],
    name: "UUPSUnsupportedProxiableUUID",
    type: "error",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint64",
        name: "version",
        type: "uint64",
      },
    ],
    name: "Initialized",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "previousOwner",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "newOwner",
        type: "address",
      },
    ],
    name: "OwnershipTransferred",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "implementation",
        type: "address",
      },
    ],
    name: "Upgraded",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "vault",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "asset",
        type: "address",
      },
      {
        indexed: false,
        internalType: "string",
        name: "name",
        type: "string",
      },
      {
        indexed: false,
        internalType: "string",
        name: "symbol",
        type: "string",
      },
    ],
    name: "VaultCreated",
    type: "event",
  },
  {
    inputs: [],
    name: "UPGRADE_INTERFACE_VERSION",
    outputs: [
      {
        internalType: "string",
        name: "",
        type: "string",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "contract IERC20",
        name: "asset",
        type: "address",
      },
      {
        internalType: "contract IStrategy",
        name: "strategy",
        type: "address",
      },
      {
        internalType: "address",
        name: "vaultMaster",
        type: "address",
      },
      {
        internalType: "address",
        name: "agent",
        type: "address",
      },
      {
        internalType: "string",
        name: "name",
        type: "string",
      },
      {
        internalType: "string",
        name: "symbol",
        type: "string",
      },
    ],
    name: "createVault",
    outputs: [
      {
        internalType: "address",
        name: "vault",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "getAllVaults",
    outputs: [
      {
        internalType: "address[]",
        name: "",
        type: "address[]",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "getVaultCount",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "initialize",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "owner",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "proxiableUUID",
    outputs: [
      {
        internalType: "bytes32",
        name: "",
        type: "bytes32",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "renounceOwnership",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "newOwner",
        type: "address",
      },
    ],
    name: "transferOwnership",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "newImplementation",
        type: "address",
      },
      {
        internalType: "bytes",
        name: "data",
        type: "bytes",
      },
    ],
    name: "upgradeToAndCall",
    outputs: [],
    stateMutability: "payable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    name: "vaults",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
];

const _bytecode =
  "0x60a060405230608052348015610013575f5ffd5b5061001c610021565b6100d3565b7ff0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00805468010000000000000000900460ff16156100715760405163f92ee8a960e01b815260040160405180910390fd5b80546001600160401b03908116146100d05780546001600160401b0319166001600160401b0390811782556040519081527fc7f505b2f371ae2175ee4913f4499e1f2633a7b5936321eed1cdaeb6115181d29060200160405180910390a15b50565b6080516135176100f95f395f81816105d701528181610600015261074401526135175ff3fe60806040526004361061009a575f3560e01c80638c64ea4a116100625780638c64ea4a146101155780638da5cb5b1461014c5780638e7147b31461018857806397331bf9146101a7578063ad3cb1cc146101c8578063f2fde38b14610205575f5ffd5b80634f1ef2861461009e57806352d1902d146100b3578063715018a6146100da57806374d4e491146100ee5780638129fc1c14610101575b5f5ffd5b6100b16100ac366004610b34565b610224565b005b3480156100be575f5ffd5b506100c7610243565b6040519081526020015b60405180910390f35b3480156100e5575f5ffd5b506100b161025e565b3480156100f9575f5ffd5b505f546100c7565b34801561010c575f5ffd5b506100b1610271565b348015610120575f5ffd5b5061013461012f366004610b94565b610386565b6040516001600160a01b0390911681526020016100d1565b348015610157575f5ffd5b507f9016d09d72d40fdae2fd8ceac6b6234c7706214fd39c1cd1e609a0528c199300546001600160a01b0316610134565b348015610193575f5ffd5b506101346101a2366004610bc9565b6103ad565b3480156101b2575f5ffd5b506101bb610530565b6040516100d19190610c75565b3480156101d3575f5ffd5b506101f8604051806040016040528060058152602001640352e302e360dc1b81525081565b6040516100d19190610cee565b348015610210575f5ffd5b506100b161021f366004610d00565b61058f565b61022c6105cc565b61023582610670565b61023f8282610678565b5050565b5f61024c610739565b505f5160206134c25f395f51905f5290565b610266610782565b61026f5f6107dd565b565b7ff0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a008054600160401b810460ff16159067ffffffffffffffff165f811580156102b65750825b90505f8267ffffffffffffffff1660011480156102d25750303b155b9050811580156102e0575080155b156102fe5760405163f92ee8a960e01b815260040160405180910390fd5b845467ffffffffffffffff19166001178555831561032857845460ff60401b1916600160401b1785555b6103313361084d565b61033961085e565b831561037f57845460ff60401b19168555604051600181527fc7f505b2f371ae2175ee4913f4499e1f2633a7b5936321eed1cdaeb6115181d29060200160405180910390a15b5050505050565b5f8181548110610394575f80fd5b5f918252602090912001546001600160a01b0316905081565b5f6001600160a01b0387166104095760405162461bcd60e51b815260206004820152601f60248201527f45524332303a20696e76616c696420636f6e747261637420616464726573730060448201526064015b60405180910390fd5b6001600160a01b03851661045f5760405162461bcd60e51b815260206004820152601b60248201527f5661756c743a20696e76616c6964207661756c74206d617374657200000000006044820152606401610400565b86868686868660405161047190610a88565b61048096959493929190610d1b565b604051809103905ff080158015610499573d5f5f3e3d5ffd5b505f80546001810182559080527f290decd9548b62a8d60345a988386fc84ba6bc95484008f6362f93160ef3e5630180546001600160a01b0319166001600160a01b03838116918217909255604051929350908916917ff4c8fe3d081e6833faa5b528b19b14655145aa43759aae5d58a22b9eba726e299061051e9087908790610d75565b60405180910390a39695505050505050565b60605f80548060200260200160405190810160405280929190818152602001828054801561058557602002820191905f5260205f20905b81546001600160a01b03168152600190910190602001808311610567575b5050505050905090565b610597610782565b6001600160a01b0381166105c057604051631e4fbdf760e01b81525f6004820152602401610400565b6105c9816107dd565b50565b306001600160a01b037f000000000000000000000000000000000000000000000000000000000000000016148061065257507f00000000000000000000000000000000000000000000000000000000000000006001600160a01b03166106465f5160206134c25f395f51905f52546001600160a01b031690565b6001600160a01b031614155b1561026f5760405163703e46dd60e11b815260040160405180910390fd5b6105c9610782565b816001600160a01b03166352d1902d6040518163ffffffff1660e01b8152600401602060405180830381865afa9250505080156106d2575060408051601f3d908101601f191682019092526106cf91810190610d99565b60015b6106fa57604051634c9c8ce360e01b81526001600160a01b0383166004820152602401610400565b5f5160206134c25f395f51905f52811461072a57604051632a87526960e21b815260048101829052602401610400565b6107348383610866565b505050565b306001600160a01b037f0000000000000000000000000000000000000000000000000000000000000000161461026f5760405163703e46dd60e11b815260040160405180910390fd5b336107b47f9016d09d72d40fdae2fd8ceac6b6234c7706214fd39c1cd1e609a0528c199300546001600160a01b031690565b6001600160a01b03161461026f5760405163118cdaa760e01b8152336004820152602401610400565b7f9016d09d72d40fdae2fd8ceac6b6234c7706214fd39c1cd1e609a0528c19930080546001600160a01b031981166001600160a01b03848116918217845560405192169182907f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0905f90a3505050565b6108556108bb565b6105c981610904565b61026f6108bb565b61086f8261090c565b6040516001600160a01b038316907fbc7cd75a20ee27fd9adebab32041f755214dbc6bffa90cc0225b39da2e5c2d3b905f90a28051156108b357610734828261096f565b61023f6109e1565b7ff0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a0054600160401b900460ff1661026f57604051631afcd79f60e31b815260040160405180910390fd5b6105976108bb565b806001600160a01b03163b5f0361094157604051634c9c8ce360e01b81526001600160a01b0382166004820152602401610400565b5f5160206134c25f395f51905f5280546001600160a01b0319166001600160a01b0392909216919091179055565b60605f5f846001600160a01b03168460405161098b9190610db0565b5f60405180830381855af49150503d805f81146109c3576040519150601f19603f3d011682016040523d82523d5f602084013e6109c8565b606091505b50915091506109d8858383610a00565b95945050505050565b341561026f5760405163b398979f60e01b815260040160405180910390fd5b606082610a1557610a1082610a5f565b610a58565b8151158015610a2c57506001600160a01b0384163b155b15610a5557604051639996b31560e01b81526001600160a01b0385166004820152602401610400565b50805b9392505050565b805115610a6f5780518082602001fd5b604051630a12f52160e11b815260040160405180910390fd5b6126fb80610dc783390190565b6001600160a01b03811681146105c9575f5ffd5b634e487b7160e01b5f52604160045260245ffd5b5f5f67ffffffffffffffff841115610ad757610ad7610aa9565b50604051601f19601f85018116603f0116810181811067ffffffffffffffff82111715610b0657610b06610aa9565b604052838152905080828401851015610b1d575f5ffd5b838360208301375f60208583010152509392505050565b5f5f60408385031215610b45575f5ffd5b8235610b5081610a95565b9150602083013567ffffffffffffffff811115610b6b575f5ffd5b8301601f81018513610b7b575f5ffd5b610b8a85823560208401610abd565b9150509250929050565b5f60208284031215610ba4575f5ffd5b5035919050565b5f82601f830112610bba575f5ffd5b610a5883833560208501610abd565b5f5f5f5f5f5f60c08789031215610bde575f5ffd5b8635610be981610a95565b95506020870135610bf981610a95565b94506040870135610c0981610a95565b93506060870135610c1981610a95565b9250608087013567ffffffffffffffff811115610c34575f5ffd5b610c4089828a01610bab565b92505060a087013567ffffffffffffffff811115610c5c575f5ffd5b610c6889828a01610bab565b9150509295509295509295565b602080825282518282018190525f918401906040840190835b81811015610cb55783516001600160a01b0316835260209384019390920191600101610c8e565b509095945050505050565b5f81518084528060208401602086015e5f602082860101526020601f19601f83011685010191505092915050565b602081525f610a586020830184610cc0565b5f60208284031215610d10575f5ffd5b8135610a5881610a95565b6001600160a01b038781168252868116602083015285811660408301528416606082015260c0608082018190525f90610d5690830185610cc0565b82810360a0840152610d688185610cc0565b9998505050505050505050565b604081525f610d876040830185610cc0565b82810360208401526109d88185610cc0565b5f60208284031215610da9575f5ffd5b5051919050565b5f82518060208501845e5f92019182525091905056fe60c060405234801561000f575f5ffd5b506040516126fb3803806126fb83398101604081905261002e916104d5565b858282600361003d8382610609565b50600461004a8282610609565b5050505f5f61005e8361025460201b60201c565b915091508161006e576012610070565b805b60ff1660a05250506001600160a01b03908116608052600160065560408051631f1fcd5160e01b8152905191871691631f1fcd51916004808201926020929091908290030181865afa1580156100c8573d5f5f3e3d5ffd5b505050506040513d601f19601f820116820180604052508101906100ec91906106c3565b6001600160a01b0316866001600160a01b03161461015c5760405162461bcd60e51b815260206004820152602360248201527f5661756c743a206173736574206d69736d61746368207769746820737472617460448201526265677960e81b606482015260840160405180910390fd5b600780546001600160a01b0319166001600160a01b0387811691821790925560405163095ea7b360e01b815260048101919091525f1960248201529087169063095ea7b3906044016020604051808303815f875af11580156101c0573d5f5f3e3d5ffd5b505050506040513d601f19601f820116820180604052508101906101e491906106e5565b506101fc5f5160206126bb5f395f51905f528561032a565b506102215f5160206126db5f395f51905f525f5160206126bb5f395f51905f526103d7565b6001600160a01b03831615610249576102475f5160206126db5f395f51905f528461032a565b505b505050505050610731565b60408051600481526024810182526020810180516001600160e01b031663313ce56760e01b17905290515f918291829182916001600160a01b0387169161029a91610704565b5f60405180830381855afa9150503d805f81146102d2576040519150601f19603f3d011682016040523d82523d5f602084013e6102d7565b606091505b50915091508180156102eb57506020815110155b1561031e575f81806020019051810190610305919061071a565b905060ff811161031c576001969095509350505050565b505b505f9485945092505050565b5f8281526005602090815260408083206001600160a01b038516845290915281205460ff166103ce575f8381526005602090815260408083206001600160a01b03861684529091529020805460ff191660011790556103863390565b6001600160a01b0316826001600160a01b0316847f2f8788117e7eff1d82e926ec794901d17c78024a50270940304540a733656f0d60405160405180910390a45060016103d1565b505f5b92915050565b5f82815260056020526040808220600101805490849055905190918391839186917fbd79b86ffe0ab8e8776151514217cd7cacd52c909f66475c3af44e129f0b00ff9190a4505050565b6001600160a01b0381168114610435575f5ffd5b50565b634e487b7160e01b5f52604160045260245ffd5b5f82601f83011261045b575f5ffd5b81516001600160401b0381111561047457610474610438565b604051601f8201601f19908116603f011681016001600160401b03811182821017156104a2576104a2610438565b6040528181528382016020018510156104b9575f5ffd5b8160208501602083015e5f918101602001919091529392505050565b5f5f5f5f5f5f60c087890312156104ea575f5ffd5b86516104f581610421565b602088015190965061050681610421565b604088015190955061051781610421565b606088015190945061052881610421565b60808801519093506001600160401b03811115610543575f5ffd5b61054f89828a0161044c565b60a089015190935090506001600160401b0381111561056c575f5ffd5b61057889828a0161044c565b9150509295509295509295565b600181811c9082168061059957607f821691505b6020821081036105b757634e487b7160e01b5f52602260045260245ffd5b50919050565b601f82111561060457805f5260205f20601f840160051c810160208510156105e25750805b601f840160051c820191505b81811015610601575f81556001016105ee565b50505b505050565b81516001600160401b0381111561062257610622610438565b610636816106308454610585565b846105bd565b6020601f821160018114610668575f83156106515750848201515b5f19600385901b1c1916600184901b178455610601565b5f84815260208120601f198516915b828110156106975787850151825560209485019460019092019101610677565b50848210156106b457868401515f19600387901b60f8161c191681555b50505050600190811b01905550565b5f602082840312156106d3575f5ffd5b81516106de81610421565b9392505050565b5f602082840312156106f5575f5ffd5b815180151581146106de575f5ffd5b5f82518060208501845e5f920191825250919050565b5f6020828403121561072a575f5ffd5b5051919050565b60805160a051611f2a6107915f395f6107da01525f818161039e015281816105e0015281816108ee015281816109ec01528181610c6201528181610da301528181610e3401528181610f720152818161137e015261143e0152611f2a5ff3fe608060405234801561000f575f5ffd5b506004361061024a575f3560e01c806370a0823111610140578063c63d75b6116100bf578063d905777e11610084578063d905777e146104fa578063dd62ed3e1461050d578063de5f626814610545578063e43043131461054d578063ef8b30f7146104b9578063f975731314610560575f5ffd5b8063c63d75b6146103d6578063c6e6f592146104b9578063ce96cb77146104cc578063d389800f146104df578063d547741f146104e7575f5ffd5b8063a8c62e7611610105578063a8c62e761461045a578063a9059cbb1461046d578063b3d7f6b914610480578063b460af9414610493578063ba087652146104a6575f5ffd5b806370a08231146103fd57806391d148541461042557806394bf804d1461043857806395d89b411461044b578063a217fddf14610453575f5ffd5b8063248a9ca3116101cc57806336568abe1161019157806336568abe1461038957806338d52e0f1461039c578063402d267d146103d65780634cdad506146102a15780636e553f65146103ea575f5ffd5b8063248a9ca31461031d5780632f2ff15d1461033f5780632f4350c214610354578063313ce5671461035c57806333a100ca14610376575f5ffd5b80630a28a477116102125780630a28a477146102c75780631650aba5146102da57806318160ddd146102ee57806322459e18146102f657806323b872dd1461030a575f5ffd5b806301e1d1141461024e57806301ffc9a71461026957806306fdde031461028c57806307a2d13a146102a1578063095ea7b3146102b4575b5f5ffd5b610256610573565b6040519081526020015b60405180910390f35b61027c610277366004611ab8565b610676565b6040519015158152602001610260565b6102946106ac565b6040516102609190611adf565b6102566102af366004611b14565b61073c565b61027c6102c2366004611b3f565b610747565b6102566102d5366004611b14565b61075e565b6102565f516020611eb55f395f51905f5281565b600254610256565b6102565f516020611ed55f395f51905f5281565b61027c610318366004611b69565b61076a565b61025661032b366004611b14565b5f9081526005602052604090206001015490565b61035261034d366004611ba7565b61078f565b005b6102566107b9565b6103646107d3565b60405160ff9091168152602001610260565b610352610384366004611bd5565b6107fe565b610352610397366004611ba7565b610abe565b7f00000000000000000000000000000000000000000000000000000000000000005b6040516001600160a01b039091168152602001610260565b6102566103e4366004611bd5565b505f1990565b6102566103f8366004611ba7565b610af6565b61025661040b366004611bd5565b6001600160a01b03165f9081526020819052604090205490565b61027c610433366004611ba7565b610b7f565b610256610446366004611ba7565b610ba9565b610294610bcc565b6102565f81565b6007546103be906001600160a01b031681565b61027c61047b366004611b3f565b610bdb565b61025661048e366004611b14565b610be8565b6102566104a1366004611bf0565b610bf4565b6102566104b4366004611bf0565b610c4a565b6102566104c7366004611b14565b610d73565b6102566104da366004611bd5565b610d7e565b610352610da0565b6103526104f5366004611ba7565b610f2d565b610256610508366004611bd5565b610f51565b61025661051b366004611c2f565b6001600160a01b039182165f90815260016020908152604080832093909416825291909152205490565b610256610f6e565b61035261055b366004611bd5565b61100b565b61035261056e366004611bd5565b611085565b6007546040805163722713f760e01b815290515f926001600160a01b03169163722713f79160048083019260209291908290030181865afa1580156105ba573d5f5f3e3d5ffd5b505050506040513d601f19601f820116820180604052508101906105de9190611c5b565b7f00000000000000000000000000000000000000000000000000000000000000006040516370a0823160e01b81523060048201526001600160a01b0391909116906370a0823190602401602060405180830381865afa158015610643573d5f5f3e3d5ffd5b505050506040513d601f19601f820116820180604052508101906106679190611c5b565b6106719190611c86565b905090565b5f6001600160e01b03198216637965db0b60e01b14806106a657506301ffc9a760e01b6001600160e01b03198316145b92915050565b6060600380546106bb90611c99565b80601f01602080910402602001604051908101604052809291908181526020018280546106e790611c99565b80156107325780601f1061070957610100808354040283529160200191610732565b820191905f5260205f20905b81548152906001019060200180831161071557829003601f168201915b5050505050905090565b5f6106a6825f6110ff565b5f33610754818585611137565b5060019392505050565b5f6106a6826001611144565b5f33610777858285611173565b6107828585856111d5565b60019150505b9392505050565b5f828152600560205260409020600101546107a981611232565b6107b3838361123c565b50505050565b335f90815260208190526040812054610671903333610c4a565b5f610671817f0000000000000000000000000000000000000000000000000000000000000000611cd1565b6108155f516020611eb55f395f51905f5233610b7f565b8061083257506108325f516020611ed55f395f51905f5233610b7f565b6108835760405162461bcd60e51b815260206004820152601860248201527f43616c6c6572206973206e6f7420617574686f72697a6564000000000000000060448201526064015b60405180910390fd5b806001600160a01b0316631f1fcd516040518163ffffffff1660e01b8152600401602060405180830381865afa1580156108bf573d5f5f3e3d5ffd5b505050506040513d601f19601f820116820180604052508101906108e39190611cea565b6001600160a01b03167f00000000000000000000000000000000000000000000000000000000000000006001600160a01b03161461096e5760405162461bcd60e51b815260206004820152602260248201527f5661756c743a206e6577207374726174656779206173736574206d69736d61746044820152610c6d60f31b606482015260840161087a565b60075f9054906101000a90046001600160a01b03166001600160a01b0316636ba1b3e06040518163ffffffff1660e01b81526004015f604051808303815f87803b1580156109ba575f5ffd5b505af11580156109cc573d5f5f3e3d5ffd5b5050600780546001600160a01b0319166001600160a01b038516179055507f0000000000000000000000000000000000000000000000000000000000000000905060405163095ea7b360e01b81526001600160a01b0383811660048301525f196024830152919091169063095ea7b3906044016020604051808303815f875af1158015610a5b573d5f5f3e3d5ffd5b505050506040513d601f19601f82011682018060405250810190610a7f9190611d05565b50610a88610da0565b6040516001600160a01b038216907fafd1cdc355e15bfc9038294be1c6203ce953704fda8c991bebe78ddd4d5420d1905f90a250565b6001600160a01b0381163314610ae75760405163334bd91960e11b815260040160405180910390fd5b610af182826112cd565b505050565b5f610aff611338565b60075f9054906101000a90046001600160a01b03166001600160a01b031663573fef0a6040518163ffffffff1660e01b81526004015f604051808303815f87803b158015610b4b575f5ffd5b505af1158015610b5d573d5f5f3e3d5ffd5b50505050610b6b8383611362565b9050610b75610da0565b6106a66001600655565b5f9182526005602090815260408084206001600160a01b0393909316845291905290205460ff1690565b5f5f195f610bb685610be8565b9050610bc433858388611379565b949350505050565b6060600480546106bb90611c99565b5f336107548185856111d5565b5f6106a68260016110ff565b5f5f610bff83610d7e565b905080851115610c2857828582604051633fa733bb60e21b815260040161087a93929190611d24565b5f610c328661075e565b9050610c41338686898561140b565b95945050505050565b5f610c53611338565b5f610c5d8561073c565b90505f7f00000000000000000000000000000000000000000000000000000000000000006040516370a0823160e01b81523060048201526001600160a01b0391909116906370a0823190602401602060405180830381865afa158015610cc5573d5f5f3e3d5ffd5b505050506040513d601f19601f82011682018060405250810190610ce99190611c5b565b905081811015610d5a575f610cfe8284611d45565b600754604051632e1a7d4d60e01b8152600481018390529192506001600160a01b031690632e1a7d4d906024015f604051808303815f87803b158015610d42575f5ffd5b505af1158015610d54573d5f5f3e3d5ffd5b50505050505b610d658686866114cb565b925050506107886001600655565b5f6106a6825f611144565b6001600160a01b0381165f908152602081905260408120546106a6905f6110ff565b5f7f00000000000000000000000000000000000000000000000000000000000000006040516370a0823160e01b81523060048201526001600160a01b0391909116906370a0823190602401602060405180830381865afa158015610e06573d5f5f3e3d5ffd5b505050506040513d601f19601f82011682018060405250810190610e2a9190611c5b565b90508015610f2a577f000000000000000000000000000000000000000000000000000000000000000060075460405163a9059cbb60e01b81526001600160a01b0391821660048201526024810184905291169063a9059cbb906044016020604051808303815f875af1158015610ea2573d5f5f3e3d5ffd5b505050506040513d601f19601f82011682018060405250810190610ec69190611d05565b5060075f9054906101000a90046001600160a01b03166001600160a01b031663d0e30db06040518163ffffffff1660e01b81526004015f604051808303815f87803b158015610f13575f5ffd5b505af1158015610f25573d5f5f3e3d5ffd5b505050505b50565b5f82815260056020526040902060010154610f4781611232565b6107b383836112cd565b6001600160a01b0381165f908152602081905260408120546106a6565b5f807f00000000000000000000000000000000000000000000000000000000000000006040516370a0823160e01b81523360048201526001600160a01b0391909116906370a0823190602401602060405180830381865afa158015610fd5573d5f5f3e3d5ffd5b505050506040513d601f19601f82011682018060405250810190610ff99190611c5b565b90506110058133610af6565b91505090565b6110225f516020611eb55f395f51905f5233610b7f565b61106e5760405162461bcd60e51b815260206004820152601c60248201527f43616c6c6572206973206e6f742061207661756c74206d617374657200000000604482015260640161087a565b610f2a5f516020611ed55f395f51905f5282610f2d565b61109c5f516020611eb55f395f51905f5233610b7f565b6110e85760405162461bcd60e51b815260206004820152601c60248201527f43616c6c6572206973206e6f742061207661756c74206d617374657200000000604482015260640161087a565b610f2a5f516020611ed55f395f51905f528261078f565b5f61078861110b610573565b611116906001611c86565b6111215f600a611e3b565b60025461112e9190611c86565b85919085611518565b610af18383836001611565565b5f61078861115382600a611e3b565b6002546111609190611c86565b611168610573565b61112e906001611c86565b6001600160a01b038381165f908152600160209081526040808320938616835292905220545f1981146107b357818110156111c757828183604051637dc7a0d960e11b815260040161087a93929190611d24565b6107b384848484035f611565565b6001600160a01b0383166111fe57604051634b637e8f60e11b81525f600482015260240161087a565b6001600160a01b0382166112275760405163ec442f0560e01b81525f600482015260240161087a565b610af1838383611629565b610f2a813361173c565b5f6112478383610b7f565b6112c6575f8381526005602090815260408083206001600160a01b03861684529091529020805460ff1916600117905561127e3390565b6001600160a01b0316826001600160a01b0316847f2f8788117e7eff1d82e926ec794901d17c78024a50270940304540a733656f0d60405160405180910390a45060016106a6565b505f6106a6565b5f6112d88383610b7f565b156112c6575f8381526005602090815260408083206001600160a01b0386168085529252808320805460ff1916905551339286917ff6391f5c32d9c69d2a47ea670b442974b53935d1edc7fd64eb21e047a839171b9190a45060016106a6565b60026006540361135b57604051633ee5aeb560e01b815260040160405180910390fd5b6002600655565b5f5f195f61136f85610d73565b9050610bc4338587845b6113a57f0000000000000000000000000000000000000000000000000000000000000000853085611779565b6113af83826117e0565b826001600160a01b0316846001600160a01b03167fdcbc1c05240f31ff3ad067ef1ee35ce4997762752e3a095284754544f4c709d784846040516113fd929190918252602082015260400190565b60405180910390a350505050565b826001600160a01b0316856001600160a01b03161461142f5761142f838683611173565b6114398382611814565b6114647f00000000000000000000000000000000000000000000000000000000000000008584611848565b826001600160a01b0316846001600160a01b0316866001600160a01b03167ffbde797d201c681b91056529119e0b02407c7bb96a4a2c75c01fc9667232c8db85856040516114bc929190918252602082015260400190565b60405180910390a45050505050565b5f5f6114d683610f51565b9050808511156114ff57828582604051632e52afbb60e21b815260040161087a93929190611d24565b5f6115098661073c565b9050610c41338686848a61140b565b5f5f611525868686611879565b905061153083611938565b801561154b57505f848061154657611546611e49565b868809115b15610c415761155b600182611c86565b9695505050505050565b6001600160a01b03841661158e5760405163e602df0560e01b81525f600482015260240161087a565b6001600160a01b0383166115b757604051634a1406b160e11b81525f600482015260240161087a565b6001600160a01b038085165f90815260016020908152604080832093871683529290522082905580156107b357826001600160a01b0316846001600160a01b03167f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925846040516113fd91815260200190565b6001600160a01b038316611653578060025f8282546116489190611c86565b909155506116b09050565b6001600160a01b0383165f90815260208190526040902054818110156116925783818360405163391434e360e21b815260040161087a93929190611d24565b6001600160a01b0384165f9081526020819052604090209082900390555b6001600160a01b0382166116cc576002805482900390556116ea565b6001600160a01b0382165f9081526020819052604090208054820190555b816001600160a01b0316836001600160a01b03167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef8360405161172f91815260200190565b60405180910390a3505050565b6117468282610b7f565b6117755760405163e2517d3f60e01b81526001600160a01b03821660048201526024810183905260440161087a565b5050565b6040516001600160a01b0384811660248301528381166044830152606482018390526107b39186918216906323b872dd906084015b604051602081830303815290604052915060e01b6020820180516001600160e01b038381831617835250505050611964565b6001600160a01b0382166118095760405163ec442f0560e01b81525f600482015260240161087a565b6117755f8383611629565b6001600160a01b03821661183d57604051634b637e8f60e11b81525f600482015260240161087a565b611775825f83611629565b6040516001600160a01b03838116602483015260448201839052610af191859182169063a9059cbb906064016117ae565b5f838302815f1985870982811083820303915050805f036118ad578382816118a3576118a3611e49565b0492505050610788565b8084116118cd5760405163227bc15360e01b815260040160405180910390fd5b5f848688095f868103871696879004966002600389028118808a02820302808a02820302808a02820302808a02820302808a02820302808a02909103029181900381900460010186841190950394909402919094039290920491909117919091029150509392505050565b5f600282600381111561194d5761194d611e5d565b6119579190611e71565b60ff166001149050919050565b5f6119786001600160a01b038416836119c5565b905080515f1415801561199c57508080602001905181019061199a9190611d05565b155b15610af157604051635274afe760e01b81526001600160a01b038416600482015260240161087a565b606061078883835f845f5f856001600160a01b031684866040516119e99190611e9e565b5f6040518083038185875af1925050503d805f8114611a23576040519150601f19603f3d011682016040523d82523d5f602084013e611a28565b606091505b509150915061155b868383606082611a4857611a4382611a8f565b610788565b8151158015611a5f57506001600160a01b0384163b155b15611a8857604051639996b31560e01b81526001600160a01b038516600482015260240161087a565b5080610788565b805115611a9f5780518082602001fd5b604051630a12f52160e11b815260040160405180910390fd5b5f60208284031215611ac8575f5ffd5b81356001600160e01b031981168114610788575f5ffd5b602081525f82518060208401528060208501604085015e5f604082850101526040601f19601f83011684010191505092915050565b5f60208284031215611b24575f5ffd5b5035919050565b6001600160a01b0381168114610f2a575f5ffd5b5f5f60408385031215611b50575f5ffd5b8235611b5b81611b2b565b946020939093013593505050565b5f5f5f60608486031215611b7b575f5ffd5b8335611b8681611b2b565b92506020840135611b9681611b2b565b929592945050506040919091013590565b5f5f60408385031215611bb8575f5ffd5b823591506020830135611bca81611b2b565b809150509250929050565b5f60208284031215611be5575f5ffd5b813561078881611b2b565b5f5f5f60608486031215611c02575f5ffd5b833592506020840135611c1481611b2b565b91506040840135611c2481611b2b565b809150509250925092565b5f5f60408385031215611c40575f5ffd5b8235611c4b81611b2b565b91506020830135611bca81611b2b565b5f60208284031215611c6b575f5ffd5b5051919050565b634e487b7160e01b5f52601160045260245ffd5b808201808211156106a6576106a6611c72565b600181811c90821680611cad57607f821691505b602082108103611ccb57634e487b7160e01b5f52602260045260245ffd5b50919050565b60ff81811683821601908111156106a6576106a6611c72565b5f60208284031215611cfa575f5ffd5b815161078881611b2b565b5f60208284031215611d15575f5ffd5b81518015158114610788575f5ffd5b6001600160a01b039390931683526020830191909152604082015260600190565b818103818111156106a6576106a6611c72565b6001815b6001841115611d9357808504811115611d7757611d77611c72565b6001841615611d8557908102905b60019390931c928002611d5c565b935093915050565b5f82611da9575060016106a6565b81611db557505f6106a6565b8160018114611dcb5760028114611dd557611df1565b60019150506106a6565b60ff841115611de657611de6611c72565b50506001821b6106a6565b5060208310610133831016604e8410600b8410161715611e14575081810a6106a6565b611e205f198484611d58565b805f1904821115611e3357611e33611c72565b029392505050565b5f61078860ff841683611d9b565b634e487b7160e01b5f52601260045260245ffd5b634e487b7160e01b5f52602160045260245ffd5b5f60ff831680611e8f57634e487b7160e01b5f52601260045260245ffd5b8060ff84160691505092915050565b5f82518060208501845e5f92019182525091905056fe249a58af4c6bffc6f1d0bfaf4a07794c43056d7e4c0649e17e2ec82b2528da00cab5a0bfe0b79d2c4b1c2e02599fa044d115b7511f9659307cb4276950967709a2646970667358221220b13dedbc337c4361262cf2302712f237b6f288598940ea218f9d0cdfd04c460964736f6c634300081b0033249a58af4c6bffc6f1d0bfaf4a07794c43056d7e4c0649e17e2ec82b2528da00cab5a0bfe0b79d2c4b1c2e02599fa044d115b7511f9659307cb4276950967709360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbca2646970667358221220e5e6759b96ac4d73640179207209b264002c0830352910017f658ada38775be464736f6c634300081b0033";

export class AgentVaultFactory__factory extends ContractFactory {
  constructor(signer?: Signer) {
    super(_abi, _bytecode, signer);
  }

  deploy(
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<AgentVaultFactory> {
    return super.deploy(overrides || {}) as Promise<AgentVaultFactory>;
  }
  getDeployTransaction(
    overrides?: Overrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(overrides || {});
  }
  attach(address: string): AgentVaultFactory {
    return super.attach(address) as AgentVaultFactory;
  }
  connect(signer: Signer): AgentVaultFactory__factory {
    return super.connect(signer) as AgentVaultFactory__factory;
  }
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): AgentVaultFactoryInterface {
    return new utils.Interface(_abi) as AgentVaultFactoryInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): AgentVaultFactory {
    return new Contract(address, _abi, signerOrProvider) as AgentVaultFactory;
  }
}
