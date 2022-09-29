pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import"@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";


interface IPancakeRouter01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

// File: contracts\interfaces\IPancakeRouter02.sol

pragma solidity >=0.6.2;

interface IPancakeRouter02 is IPancakeRouter01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}



contract greedyverseNfts is ERC1155, Ownable{
    using SafeMath for uint256;

    address payable public marketing_contestWallet;
    address payable public teamWallet;
    address payable public gameDevWallet;

    string public name = "GreedyVerseNFT";
    string public symbol = "GNFT";

    uint256[30] public maxNftsAmount = [90000, 30000, 1800000, 1800000, 60000, 60000, 48000, 48000, 27000, 30000, 90000, 30000, 8100, 13500, 21600, 120000, 180000, 21600, 240000, 120000, 7200, 8100, 9750, 30000, 120000, 30000, 240000, 480000, 120000, 60000];
    
    uint256[30] public mintedNftsAmount = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    uint256[30] public nftMintPrice = [
        40000000000000000,
        120000000000000000,
        1500000000000000,
        1500000000000000,
        60000000000000000,
        60000000000000000,
        75000000000000000,
        75000000000000000,
        133333333333333330,
        120000000000000000,
        40000000000000000,
        120000000000000000,
        444444444444444400,
        266666666666666660,
        166666666666666660,
        30000000000000000,
        20000000000000000,
        166666666666666660,
        15000000000000000,
        30000000000000000,
        500000000000000000,
        444444444444444400,
        369230769230769250,
        120000000000000000,
        30000000000000000,
        120000000000000000,
        15000000000000000,
        7500000000000000,
        30000000000000000,
        120000000000000000
    ];

     uint256 public spMaxNftAmount_perNft = 40;
     uint256 public MaxStoneWall_per_player = 30;
     uint256 public MaxWoodWall_per_player = 30;
     uint256 public MaxLand_per_player = 5;
     uint256 public MaxDragon_per_player = 2;
     uint256 public MaxBabyDragon_per_player = 2;
     uint256 public MaxGolem_per_player = 3;
     uint256 public MaxGrandWarden_per_player = 3;
     uint256 public MaxDrone_per_player = 3;
     address greedyverseToken = 0xb546fC62DcB523C4f5F1581021Bf27A8019b5516;

     IPancakeRouter02 public immutable pancakeswapV2Router;

     struct nftItem
        {
            uint256 totalHealth;
            uint256 amount;
        }

    mapping (address => mapping(uint256 => nftItem)) public holders;

    mapping (address => mapping(uint256 => uint256)) public singlePlayeramount;

    mapping(address => bool) isWhiteListed;

    bool public Mint = false;
    bool public PublicMint = false;


    constructor() ERC1155("https://greedyverse.co/api/getNftMetaData.php?id={id}"){
      marketing_contestWallet = payable(0x22B7b595E4BD0304BBB55e475a01adc573986c5F);
      teamWallet = payable(0x9e560d6A9E13cf6fBe7A4819AeaF9a05453932C3);
      gameDevWallet = payable(0x64216e7cD90a112d547C92018e3F8fd2055e4B01);

      IPancakeRouter02 _pancakeswapV2Router = IPancakeRouter02(0x10ED43C718714eb63d5aA57B78B54704E256024E);
      pancakeswapV2Router = _pancakeswapV2Router;
    }

    function addToWhiteList(address user) public onlyOwner{
        isWhiteListed[user] = true;
    }

     function removeFromWhiteList(address user) public onlyOwner{
        isWhiteListed[user] = false;
    }

    function whiteListMint(uint256 id, uint256 amount) public payable{
        require(!PublicMint, "Private mint is ended");
        require(isWhiteListed[msg.sender], "Address not whitelisted for minting");
        _mint(id,amount);
    }

     function revive(uint256 id, uint256 amount) public payable{
        require(msg.sender != address(0), "Cannot revive on a zero address");
        require(msg.value >= (nftMintPrice[id].div(2)).mul(amount), "Amount too small to revive nft");

        holders[msg.sender][id].totalHealth = (holders[msg.sender][id].totalHealth).add((nftMintPrice[id].div(2)).mul(amount));
    }

    function payWinnings(uint256[] memory player1destructionlist, uint256[] memory player2destructionlist, address player1, address player2) public onlyOwner{
        uint256 TotalPlayer1payment = 0;
        uint256 TotalPlayer2payment = 0;
   
        for (uint i=0; i<player1destructionlist.length; i++) {
           TotalPlayer1payment = TotalPlayer1payment.add(nftMintPrice[player1destructionlist[i]].div(2)); 
        }

        for (uint i=0; i<player2destructionlist.length; i++) {
           TotalPlayer2payment = TotalPlayer2payment.add(nftMintPrice[player2destructionlist[i]].div(2)); 
        }

        swapETHForTokens(TotalPlayer1payment, player1);
        swapETHForTokens(TotalPlayer2payment, player2);
    } 


      function swapETHForTokens(uint256 amount, address to) private {
       
             address[] memory path = new address[](2);
        path[0] = pancakeswapV2Router.WETH();
        path[1] = greedyverseToken;
        
        pancakeswapV2Router.swapExactETHForTokensSupportingFeeOnTransferTokens{value: amount}(
            0, 
            path, 
            to,
            block.timestamp + 15
        );
        

    }



      function mint(uint256 id, uint256 amount) public payable{
        require(PublicMint, "Public mint has not started");
        _mint(id,amount);
    }

    function _mint(uint256 id, uint256 amount) internal {
         require(Mint, "Minting has not started");
         require(msg.sender != address(0), "Cannot mint to a zero address");
         require(mintedNftsAmount[id].add(amount) < maxNftsAmount[id], "Mint amount not available");
         require(msg.value >= nftMintPrice[id].mul(amount), "Amount too small to mint nft");
         if(id == 2){
             require((singlePlayeramount[msg.sender][id].add(amount) <= MaxWoodWall_per_player), "You can not mint more than 30 wood walls");
         }else if(id == 3){
             require((singlePlayeramount[msg.sender][id].add(amount) <= MaxStoneWall_per_player), "You can not mint more than 30 stone walls");
         }else if(id == 29){
             require((singlePlayeramount[msg.sender][id].add(amount) <= MaxLand_per_player), "You can not mint more than 5 land");
         }else if(id == 20){
             require((singlePlayeramount[msg.sender][id].add(amount) <= MaxDragon_per_player), "You can not mint more than 2 Dragons");
         }else if(id == 21){
             require((singlePlayeramount[msg.sender][id].add(amount) <= MaxBabyDragon_per_player), "You can not mint more than 2 Baby Dragons");
         }else if(id == 22){
             require((singlePlayeramount[msg.sender][id].add(amount) <= MaxGolem_per_player), "You can not mint more than 3 Golems");
         }else if(id == 14){
             require((singlePlayeramount[msg.sender][id].add(amount) <= MaxGrandWarden_per_player), "You can not mint more than 3 Grand Warden");
         }else if(id == 8){
             require((singlePlayeramount[msg.sender][id].add(amount) <= MaxDrone_per_player), "You can not mint more than 3 Drones");
         }else{
             require((singlePlayeramount[msg.sender][id].add(amount) <= spMaxNftAmount_perNft), "You can not mint more than 40 of any NFT");
         }
         depositeProceeds(id);
         mintedNftsAmount[id] = mintedNftsAmount[id].add(amount);
        _mint(msg.sender, id, amount, "");
        singlePlayeramount[msg.sender][id] = singlePlayeramount[msg.sender][id].add(amount);

        holders[msg.sender][id].totalHealth = (nftMintPrice[id].div(2)).mul(amount);
        holders[msg.sender][id].amount = amount;
    }

    function depositeProceeds(uint256 id) private {

        if(id == 29){
        (bool success1, ) = marketing_contestWallet.call{value: msg.value.div(3)}("");
        require(success1, "Failed to deposite to marketing_contestWallet");

        (bool success2, ) = teamWallet.call{value: msg.value.div(3)}("");
        require(success2, "Failed to team wallet");

        (bool success3, ) = gameDevWallet.call{value: msg.value.div(3)}("");
        require(success3, "Failed to team wallet");

        }else{
        (bool success2, ) = teamWallet.call{value: msg.value.div(2)}("");
        require(success2, "Failed to team wallet");
        }

        
    }

    function safeTransferFrom(address from, address to, uint256 id, uint256 amount, bytes memory data) public override {
        require(
            from == _msgSender() || isApprovedForAll(from, _msgSender()),
            "ERC1155: caller is not token owner nor approved"
        );
         if(id == 2){
             require((singlePlayeramount[to][id].add(amount) <= MaxWoodWall_per_player), "No address can own more than 30 wood walls");
         }else if(id == 3){
             require((singlePlayeramount[to][id].add(amount) <= MaxStoneWall_per_player), "No address can own more than 30 stone walls");
         }else if(id == 29){
             require((singlePlayeramount[to][id].add(amount) <= MaxLand_per_player), "No address can own more than 5 land");
         }else if(id == 20){
             require((singlePlayeramount[msg.sender][id].add(amount) <= MaxDragon_per_player), "You can not mint more than 2 Dragons");
         }else if(id == 21){
             require((singlePlayeramount[msg.sender][id].add(amount) <= MaxBabyDragon_per_player), "You can not mint more than 2 Baby Dragons");
         }else if(id == 22){
             require((singlePlayeramount[msg.sender][id].add(amount) <= MaxGolem_per_player), "You can not mint more than 3 Golems");
         }else if(id == 14){
             require((singlePlayeramount[msg.sender][id].add(amount) <= MaxGrandWarden_per_player), "You can not mint more than 3 Grand Warden");
         }else if(id == 8){
             require((singlePlayeramount[msg.sender][id].add(amount) <= MaxDrone_per_player), "You can not mint more than 3 Drones");
         }else{
             require((singlePlayeramount[to][id].add(amount) <= spMaxNftAmount_perNft), "No address can own more than 40 of any NFT");
         }
        _safeTransferFrom(from, to, id, amount, data);
        singlePlayeramount[from][id] = (singlePlayeramount[from][id]).sub(amount);
        singlePlayeramount[to][id] = (singlePlayeramount[to][id]).add(amount);

        holders[from][id].totalHealth = (holders[from][id].totalHealth).sub((nftMintPrice[id].div(2)).mul(amount));
        holders[from][id].amount = (holders[from][id].amount).sub(amount);
        holders[to][id].totalHealth = (nftMintPrice[id].div(2)).mul(amount);
        holders[to][id].amount = amount;
    }

    function safeBatchTransferFrom(address from,address to,uint256[] memory ids,uint256[] memory amounts,bytes memory data) public override{
        
        for(uint256 i = 0; i < ids.length;i++){


            require(
                    from == _msgSender() || isApprovedForAll(from, _msgSender()),
                    "ERC1155: caller is not token owner nor approved"
            );
            uint256 id = ids[i];
            uint256 amount = amounts[i];
         if(id == 2){
             require((singlePlayeramount[to][id].add(amount) <= MaxWoodWall_per_player), "No address can own more than 30 wood walls");
         }else if(id == 3){
             require((singlePlayeramount[to][id].add(amount) <= MaxStoneWall_per_player), "No address can own more than 30 stone walls");
         }else if(id == 29){
             require((singlePlayeramount[to][id].add(amount) <= MaxLand_per_player), "No address can own more than 5 land");
         }else if(id == 20){
             require((singlePlayeramount[msg.sender][id].add(amount) <= MaxDragon_per_player), "You can not mint more than 2 Dragons");
         }else if(id == 21){
             require((singlePlayeramount[msg.sender][id].add(amount) <= MaxBabyDragon_per_player), "You can not mint more than 2 Baby Dragons");
         }else if(id == 22){
             require((singlePlayeramount[msg.sender][id].add(amount) <= MaxGolem_per_player), "You can not mint more than 3 Golems");
         }else if(id == 14){
             require((singlePlayeramount[msg.sender][id].add(amount) <= MaxGrandWarden_per_player), "You can not mint more than 3 Grand Warden");
         }else if(id == 8){
             require((singlePlayeramount[msg.sender][id].add(amount) <= MaxDrone_per_player), "You can not mint more than 3 Drones");
         }else{
             require((singlePlayeramount[to][id].add(amount) <= spMaxNftAmount_perNft), "No address can own more than 40 of any NFT");
         }
            singlePlayeramount[from][id] = (singlePlayeramount[from][id]).sub(amount);
            singlePlayeramount[to][id] = (singlePlayeramount[to][id]).add(amount);

            holders[from][id].totalHealth = (holders[from][id].totalHealth).sub((nftMintPrice[id].div(2)).mul(amount));
            holders[from][id].amount = (holders[from][id].amount).sub(amount);
            holders[to][id].totalHealth = (nftMintPrice[id].div(2)).mul(amount);
            holders[to][id].amount = amount;

        }
        _safeBatchTransferFrom(from,to,ids,amounts,data);
    }

    function getPlayerNftCount(address account, uint256 id) public view returns(uint256){
        return singlePlayeramount[account][id];
    }

    function getPlayerNftAmount(address account, uint256 id) public view returns(uint256){
        return holders[account][id].amount;
    }

    function getPlayerNftTotalHealth(address account, uint256 id) public view returns(uint256){
        return holders[account][id].totalHealth;
    }

    function startMint() public onlyOwner{
        Mint = true;
    }

    function endMint() public onlyOwner{
        Mint = false;
    }

     function starPrivatetMint() public onlyOwner{
        PublicMint = false;
    }

    function endPrivatetMint() public onlyOwner{
        PublicMint = true;
    }
}
