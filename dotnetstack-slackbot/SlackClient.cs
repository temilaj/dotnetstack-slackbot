//
// SlackClient.cs
//
// Author:
//       Bolorunduro Winner-Timothy <ogatimo@gmail.com>
//
// Copyright (c) 2016 Bolorunduro Winner-Timothy
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
using System.Collections.Specialized;
using System.Runtime.Remoting.Lifetime;
using System;
using System.Text;
using Newtonsoft.Json;
using System.Net;

namespace slackbot
{
	public class SlackClient
	{
		private readonly Uri uri;
		private readonly Encoding encoding = new UTF8Encoding();

		public SlackClient (string urlWithAccessToken)
		{
			uri = new Uri (urlWithAccessToken);
		}

		public string PostMessage(string text, string username = null, string channel = null)
		{
			Payload payload = new Payload () {
				Channel = channel,
				Username = username,
				Text = text
			};

			return PostMessage (payload);
		}

		public string PostMessage(Payload payload)
		{
			string payloadJson = JsonConvert.SerializeObject (payload);

			using (WebClient webClient = new WebClient ()) {
				NameValueCollection data = new NameValueCollection ();
				data ["payload"] = payloadJson;

				var response = webClient.UploadValues (uri, "POST", data);

				return encoding.GetString (response);
			}
		}
	}
}

