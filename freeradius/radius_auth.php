<?php
/**
 * Ubersmith FreeRADIUS Module
 * 
 * This file is used by FreeRADIUS to communicate with Ubersmith for
 * authentication purposes. See
 * 
 * https://github.com/TeamUbersmith/other/freeradius
 * 
 * for details on its use.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 * @author Dan Cech <dcech@ubersmith.com>
 * @version $Id$
 * @package ubersmith
 * @subpackage default
 * @link https://github.com/TeamUbersmith/other/freeradius
 * @link http://freeradius.org/
 **/

require_once dirname(__FILE__) .'/class.uber_api_client.php';

$client = new uber_api_client('https://your.ubersmith.com','admin','admin');

$login = trim(getenv('USER_NAME'),'"');
$pass  = trim(getenv('USER_PASSWORD'),'"');

try {
	$result = $client->call('uber.check_login',array(
		'login' => $login,
		'pass'  => $pass,
	));
	if (empty($result['client_id'])) {
		throw new Exception('Could not find client id',1);
	}
	
	print 'Service-Type = "Framed-User",';
	print 'UserLogon-UserFullName = "'. $result['client_id'] .'",';
	exit(0);
	
	
	$result = $client->call('client.get',array(
		'client_id' => $result['client_id'],
		'metadata'  => 1,
	));
	
	print 'Company = "'. $result['company'] .'"'."\n";
	exit(0);
} catch (Exception $e) {
	print 'Reply-Message = "'. $login .':'. $pass .' '. $e->getMessage() .' ('. $e->getCode() .')"'."\n";
	exit(1);
}

// end of script
