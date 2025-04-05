import { BigNumber } from "ethers";

export const GAS_LIMIT = {
  NORMAL: 1000000,
  DEPLOY: 10000000,
};

export const ROOTSTOCK_GAS_PRICE = BigNumber.from(50000000);
export const POLYGON_GAS_PRICE = BigNumber.from(100000000000);
