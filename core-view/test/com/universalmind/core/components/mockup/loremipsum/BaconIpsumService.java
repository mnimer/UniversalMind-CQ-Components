/*
 * Copyright 2012 Mike Nimer & Universal Mind
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */

/**
 This file is part of 'ApiServer'.

 'ApiServer' is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 'ApiServer' is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with 'ApiServer'.  If not, see <http://www.gnu.org/licenses/>.
 **/
package com.universalmind.core.components.mockup.loremipsum;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.sling.commons.json.JSONException;
import org.apache.sling.commons.json.JSONObject;
import org.junit.Assert;
import org.junit.Test;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.ByteArrayInputStream;
import java.io.InputStream;

/**
 * User: mnimer
 * Date: 2/12/13
 */
public class BaconIpsumService
{

    @Test
    public void testService()
    {
        Integer  paragraphs  =  2;

        String loremText = null;
        String url = null;
        url = "http://baconipsum.com/api/?type=meat-and-filler&start-with-lorem=1&paras=" +paragraphs;



        HttpClient httpclient = new DefaultHttpClient();
        try {
            HttpGet httpget = new HttpGet(url);

            // Create a response handler
            ResponseHandler<String> responseHandler = new BasicResponseHandler();
            String responseBody = httpclient.execute(httpget, responseHandler);

            loremText = parseBaconIpsum(responseBody);

            Assert.assertNotNull(loremText);
            Assert.assertTrue( loremText.length() > 100 );
        }
        catch( Exception jse )
        {
            //do nothing
            jse.printStackTrace();
        }
        finally
        {
            // When HttpClient instance is no longer needed,
            // shut down the connection manager to ensure
            // immediate deallocation of all system resources
            httpclient.getConnectionManager().shutdown();
        }
    }



    public String parseBaconIpsum(String body) throws JSONException
    {
        if( body.startsWith("[") )
        {
            String[] arrayText = body.substring(2, body.length() - 2).split("\",\"");

            return StringUtils.join(arrayText, "<br/>");
        }

        return body;
    }

}
