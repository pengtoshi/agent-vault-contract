/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import { Provider, TransactionRequest } from "@ethersproject/providers";
import type { TestStrategy, TestStrategyInterface } from "../TestStrategy";

const _abi = [
  {
    inputs: [
      {
        internalType: "contract IERC20",
        name: "_want",
        type: "address",
      },
      {
        internalType: "contract TestDefi",
        name: "_defi",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [],
    name: "balanceOf",
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
    name: "beforeDeposit",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "defi",
    outputs: [
      {
        internalType: "contract TestDefi",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "deposit",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "retireStrategy",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_yieldRate",
        type: "uint256",
      },
    ],
    name: "setYieldRate",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "want",
    outputs: [
      {
        internalType: "contract IERC20",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "amount",
        type: "uint256",
      },
    ],
    name: "withdraw",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
];

const _bytecode =
  "0x60c060405234801561000f575f5ffd5b50604051610ad6380380610ad683398101604081905261002e916100ca565b6001600160a01b03828116608081905290821660a081905260405163095ea7b360e01b815260048101919091525f19602482015263095ea7b3906044016020604051808303815f875af1158015610087573d5f5f3e3d5ffd5b505050506040513d601f19601f820116820180604052508101906100ab9190610102565b505050610128565b6001600160a01b03811681146100c7575f5ffd5b50565b5f5f604083850312156100db575f5ffd5b82516100e6816100b3565b60208401519092506100f7816100b3565b809150509250929050565b5f60208284031215610112575f5ffd5b81518015158114610121575f5ffd5b9392505050565b60805160a05161092d6101a95f395f818160fa01528181610160015281816101da015281816102c3015281816103b801528181610428015281816104aa0152818161053a0152818161071e015261084401525f818160a30152818161033c015281816105b1015281816106460152818161069801526107b5015261092d5ff3fe608060405234801561000f575f5ffd5b5060043610610085575f3560e01c8063573fef0a11610058578063573fef0a1461011c5780636ba1b3e014610124578063722713f71461012c578063d0e30db014610142575f5ffd5b80631411dab0146100895780631f1fcd511461009e5780632e1a7d4d146100e257806338c0f073146100f5575b5f5ffd5b61009c61009736600461087e565b61014a565b005b6100c57f000000000000000000000000000000000000000000000000000000000000000081565b6040516001600160a01b0390911681526020015b60405180910390f35b61009c6100f036600461087e565b6101c3565b6100c57f000000000000000000000000000000000000000000000000000000000000000081565b61009c6103b6565b61009c610426565b610134610681565b6040519081526020016100d9565b61009c61079e565b6040516301411dab60e41b8152600481018290527f00000000000000000000000000000000000000000000000000000000000000006001600160a01b031690631411dab0906024015b5f604051808303815f87803b1580156101aa575f5ffd5b505af11580156101bc573d5f5f3e3d5ffd5b5050505050565b604051631676539160e01b81523060048201525f907f00000000000000000000000000000000000000000000000000000000000000006001600160a01b031690631676539190602401602060405180830381865afa158015610227573d5f5f3e3d5ffd5b505050506040513d601f19601f8201168201806040525081019061024b9190610895565b9050808211156102ad5760405162461bcd60e51b8152602060048201526024808201527f53747261746567793a20696e73756666696369656e74207374616b656420616d6044820152631bdd5b9d60e21b606482015260840160405180910390fd5b6040516305c2fbcf60e31b8152600481018390527f00000000000000000000000000000000000000000000000000000000000000006001600160a01b031690632e17de78906024015f604051808303815f87803b15801561030c575f5ffd5b505af115801561031e573d5f5f3e3d5ffd5b505060405163a9059cbb60e01b8152336004820152602481018590527f00000000000000000000000000000000000000000000000000000000000000006001600160a01b0316925063a9059cbb91506044015b6020604051808303815f875af115801561038d573d5f5f3e3d5ffd5b505050506040513d601f19601f820116820180604052508101906103b191906108ac565b505050565b7f00000000000000000000000000000000000000000000000000000000000000006001600160a01b0316634641257d6040518163ffffffff1660e01b81526004015f604051808303815f87803b15801561040e575f5ffd5b505af1158015610420573d5f5f3e3d5ffd5b50505050565b7f00000000000000000000000000000000000000000000000000000000000000006001600160a01b0316634641257d6040518163ffffffff1660e01b81526004015f604051808303815f87803b15801561047e575f5ffd5b505af1158015610490573d5f5f3e3d5ffd5b5050604051631676539160e01b81523060048201525f92507f00000000000000000000000000000000000000000000000000000000000000006001600160a01b03169150631676539190602401602060405180830381865afa1580156104f8573d5f5f3e3d5ffd5b505050506040513d601f19601f8201168201806040525081019061051c9190610895565b9050801561059a576040516305c2fbcf60e31b8152600481018290527f00000000000000000000000000000000000000000000000000000000000000006001600160a01b031690632e17de78906024015f604051808303815f87803b158015610583575f5ffd5b505af1158015610595573d5f5f3e3d5ffd5b505050505b6040516370a0823160e01b81523060048201525f907f00000000000000000000000000000000000000000000000000000000000000006001600160a01b0316906370a0823190602401602060405180830381865afa1580156105fe573d5f5f3e3d5ffd5b505050506040513d601f19601f820116820180604052508101906106229190610895565b9050801561067d5760405163a9059cbb60e01b8152336004820152602481018290527f00000000000000000000000000000000000000000000000000000000000000006001600160a01b03169063a9059cbb90604401610371565b5050565b6040516370a0823160e01b81523060048201525f907f00000000000000000000000000000000000000000000000000000000000000006001600160a01b0316906370a0823190602401602060405180830381865afa1580156106e5573d5f5f3e3d5ffd5b505050506040513d601f19601f820116820180604052508101906107099190610895565b604051631676539160e01b81523060048201527f00000000000000000000000000000000000000000000000000000000000000006001600160a01b031690631676539190602401602060405180830381865afa15801561076b573d5f5f3e3d5ffd5b505050506040513d601f19601f8201168201806040525081019061078f9190610895565b61079991906108d2565b905090565b6040516370a0823160e01b81523060048201525f907f00000000000000000000000000000000000000000000000000000000000000006001600160a01b0316906370a0823190602401602060405180830381865afa158015610802573d5f5f3e3d5ffd5b505050506040513d601f19601f820116820180604052508101906108269190610895565b9050801561087b5760405163534a7e1d60e11b8152600481018290527f00000000000000000000000000000000000000000000000000000000000000006001600160a01b03169063a694fc3a90602401610193565b50565b5f6020828403121561088e575f5ffd5b5035919050565b5f602082840312156108a5575f5ffd5b5051919050565b5f602082840312156108bc575f5ffd5b815180151581146108cb575f5ffd5b9392505050565b808201808211156108f157634e487b7160e01b5f52601160045260245ffd5b9291505056fea2646970667358221220000c0243dc60bd2a2c9c8baebbbd6c8e9915d685f6972456b01305c5f18fdd5864736f6c634300081b0033";

export class TestStrategy__factory extends ContractFactory {
  constructor(signer?: Signer) {
    super(_abi, _bytecode, signer);
  }

  deploy(
    _want: string,
    _defi: string,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): Promise<TestStrategy> {
    return super.deploy(_want, _defi, overrides || {}) as Promise<TestStrategy>;
  }
  getDeployTransaction(
    _want: string,
    _defi: string,
    overrides?: Overrides & { from?: string | Promise<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(_want, _defi, overrides || {});
  }
  attach(address: string): TestStrategy {
    return super.attach(address) as TestStrategy;
  }
  connect(signer: Signer): TestStrategy__factory {
    return super.connect(signer) as TestStrategy__factory;
  }
  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): TestStrategyInterface {
    return new utils.Interface(_abi) as TestStrategyInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): TestStrategy {
    return new Contract(address, _abi, signerOrProvider) as TestStrategy;
  }
}
