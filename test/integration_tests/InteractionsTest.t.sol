import {Test, console} from "../../lib/forge-std/src/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {WithdrawFundMe} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test {

    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant SENDVALUE = 0.1 ether;  
    uint256 constant STARTING_BALANCE = 100 ether;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }
    function testUserCanFundAndWithdraw() public {
        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        vm.prank(USER);
        fundMe.fund{value: SENDVALUE}();
        assertEq(fundMe.getAddressToAmountFunded(USER), SENDVALUE);
        withdrawFundMe.withdrawFundMe(address(fundMe));
        assertEq(fundMe.getAddressToAmountFunded(USER), 0);

    }
}