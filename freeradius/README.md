## Ubersmith FreeRADIUS Module

Ubersmith can provide authentication services to a FreeRADIUS server using the module `radius_auth.php`. Note that this module is unsupported, and provided 'as is', and is not part of the stock Ubersmith codebase. It is provided as a courtesy to the Ubersmith community. If you encounter problems with it, please open an issue so that we might resolve it in the future.

### Configuration

Ensure that a recent version of the PHP command line interface (5.2, 5.3 preferred) is installed on your FreeRADIUS server.

Create the file `/opt/freeradius/etc/raddb/modules/uber`, with the following contents:

    exec uber {
        wait = yes
        program = "/usr/bin/php /root/radius_auth.php"
        input_pairs = request
        output_pairs = reply
    }

Add an entry to the file `/opt/freeradius/etc/raddb/users`:

    DEFAULT Auth-Type := UBER

At the end of the `authenticate` block in `/opt/freeradius/etc/raddb/sites-enabled/default`, add:

    Auth-Type UBER {
        uber
    }

Place the file `radius_auth.php` in `/root` or another preferred location. If you choose a different location, be sure to update `/opt/freeradius/etc/raddb/modules/uber`. Note that `radius_auth.php` requires the Ubersmith PHP API client, a copy of which can be found in the directory `api/client/2.0/php/class.uber_api_client.php` in your Ubersmith web root. Copy this file to the same location as `radius_auth.php` on your FreeRADIUS host.

Be sure to restart your FreeRADIUS server after making these changes.

License: LGPL

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
