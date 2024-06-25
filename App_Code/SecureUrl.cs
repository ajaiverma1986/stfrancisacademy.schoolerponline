using System.Collections;
using System.Collections.Specialized;
using System.Diagnostics;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web;

public sealed class SecureUrl
{
    private const string ENCRYPTED_KEY_NAME = "param";
    private const string RETURN_URL = "returnUrl";
    private const string RETURN_PARAM = "returnParam";

    //DES Key size is 64 bit or 8 byte
    private static readonly byte[] Key = new byte[] { 33, 93, 171, 1, 85, 23, 231, 145 };

    private string _pageUrl = string.Empty;
    private StringDictionary _queryString = new StringDictionary();

    public string this[string key]
    {
        [DebuggerStepThrough()]
        get
        {
            if (_queryString.ContainsKey(key.ToLower()))
            {
                return _queryString[key];
            }

            return string.Empty;
        }
        [DebuggerStepThrough()]
        set
        {
            if ((value != null) && (value.Trim().Length > 0))
            {
                _queryString[key.ToLower()] = value;
            }
            else
            {
                _queryString.Remove(key.ToLower());
            }
        }
    }

    public string ReturnUrl
    {
        [DebuggerStepThrough()]
        get
        {
            if (_queryString.ContainsKey(RETURN_URL))
            {
                return _queryString[RETURN_URL];
            }

            return string.Empty;
        }
        [DebuggerStepThrough()]
        set
        {
            if ((value != null) && (value.Trim().Length > 0))
            {
                _queryString[RETURN_URL] = value;
            }
            else
            {
                _queryString.Remove(RETURN_URL);
            }
        }
    }

    public string ReturnParameters
    {
        [DebuggerStepThrough()]
        get
        {
            if (_queryString.ContainsKey(RETURN_PARAM))
            {
                return _queryString[RETURN_PARAM];
            }

            return string.Empty;
        }
        [DebuggerStepThrough()]
        set
        {
            if ((value != null) && (value.Trim().Length > 0))
            {
                _queryString[RETURN_PARAM] = value;
            }
            else
            {
                _queryString.Remove(RETURN_PARAM);
            }
        }
    }

    public SecureUrl(string fullUrl)
    {
        if (fullUrl.IndexOf('?') > 0)
        {
            string[] urlAndQueryString = fullUrl.Split('?');
            _pageUrl = urlAndQueryString[0];

            if (urlAndQueryString.Length > 1)
            {
                Parse(urlAndQueryString[1]);
            }
        }
        else
        {
            _pageUrl = fullUrl;
        }
    }

    public SecureUrl(string url,
    string queryString)
    {
        _pageUrl = url;
        Parse(queryString);
    }

    [DebuggerStepThrough()]
    public void Clear()
    {
        _queryString.Clear();
    }

    [DebuggerStepThrough()]
    public bool Contains(string key)
    {
        return _queryString.ContainsKey(key.ToLower());
    }

    [DebuggerStepThrough()]
    public void Remove(string key)
    {
        _queryString.Remove(key);
    }

    [DebuggerStepThrough()]
    public override string ToString()
    {
        return ToString(false);
    }

    [DebuggerStepThrough()]
    public string ToString(bool unicode)
    {
        StringBuilder queryString = new StringBuilder();

        foreach (DictionaryEntry entry in _queryString)
        {
            queryString.Append(entry.Key.ToString().ToLower());
            queryString.Append('=');
            queryString.Append(HttpUtility.UrlEncode(entry.Value.ToString()));
            queryString.Append('&');
        }

        if (queryString.Length > 0)
        {
            //Remove the last &
            queryString.Remove(queryString.Length - 1, 1);
        }

        string encryptedQuery = Encrypt(queryString.ToString());

        string encodedQuery = HttpUtility.UrlEncode(encryptedQuery);

        if (unicode)
        {
            //Required if we are passing it to JavaScript
            encodedQuery = HttpUtility.UrlEncodeUnicode(encodedQuery);
        }

        string result = string.Empty;

        if (encodedQuery.Length > 0)
        {
            result = _pageUrl + "?" + ENCRYPTED_KEY_NAME + "=" + encodedQuery;
        }
        else
        {
            result = _pageUrl;
        }

        return result;
    }

    [DebuggerStepThrough()]
    private void Parse(string queryString)
    {
        string[] pairs = queryString.Split('&');

        if ((pairs != null) && (pairs.Length > 0))
        {
            for (int i = 0; i < pairs.Length; i++)
            {
                string[] pair = pairs[i].Split('=');
                string key = pair[0];
                string value = pair[1];

                value = HttpUtility.UrlDecode(value);

                if (string.Compare(key, ENCRYPTED_KEY_NAME, true) == 0)
                {
                    if (value.Length > 0)
                    {
                        string decryptedString = HttpUtility.UrlDecode(Decrypt(value));

                        string[] keyAndValues = decryptedString.Split('&');

                        if ((keyAndValues != null) && (keyAndValues.Length > 0))
                        {
                            for (int j = 0; j < keyAndValues.Length; j++)
                            {
                                string[] keyAndValue = keyAndValues[j].Split('=');

                                if ((keyAndValue != null) && (keyAndValue.Length == 2))
                                {
                                    _queryString.Add(keyAndValue[0].ToLower(), keyAndValue[1]);
                                }
                            }
                        }
                    }
                }
                else
                {
                    _queryString.Add(key.ToLower(), value);
                }
            }
        }
    }

    [DebuggerStepThrough()]
    private static string Encrypt(string plain)
    {
        if ((plain == null) || (plain.Length == 0))
        {
            return null;
        }

        using (SymmetricAlgorithm crypto = CreateCrypto())
        {
            return System.Convert.ToBase64String(Read(crypto.CreateEncryptor(), Encoding.ASCII.GetBytes(plain)));
        }
    }

    [DebuggerStepThrough()]
    private static string Decrypt(string cipher)
    {
        if ((cipher == null) || (cipher.Length == 0))
        {
            return null;
        }

        using (SymmetricAlgorithm crypto = CreateCrypto())
        {
            return Encoding.ASCII.GetString(Read(crypto.CreateDecryptor(), System.Convert.FromBase64String(cipher)));
        }
    }

    [DebuggerStepThrough()]
    private static SymmetricAlgorithm CreateCrypto()
    {
        //Using DES as it is the fastest among the others
        SymmetricAlgorithm crypto = new DESCryptoServiceProvider();

        crypto.Key = Key;
        crypto.IV = new byte[crypto.IV.Length];

        return crypto;
    }

    [DebuggerStepThrough()]
    private static byte[] Read(ICryptoTransform transformer,
    byte[] data)
    {
        using (MemoryStream ms = new MemoryStream())
        {
            using (CryptoStream cs = new CryptoStream(ms, transformer, CryptoStreamMode.Write))
            {
                cs.Write(data, 0, data.Length);
                cs.FlushFinalBlock();

                return ms.ToArray();
            }
        }
    }
}