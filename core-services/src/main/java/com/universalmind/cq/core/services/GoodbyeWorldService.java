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

package com.universalmind.cq.core.services;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;

import org.osgi.framework.Constants;

/**
 * Example OSGi service using SCR annotations.
 */
@Component(immediate = true, metatype = true)
@Service(GoodbyeWorldService.class)
@Properties({
    @Property(name = Constants.SERVICE_VENDOR, value = "CQ Blueprints"),
    @Property(name = Constants.SERVICE_DESCRIPTION, value = "Provides a friendly farewell.")
})
public class GoodbyeWorldService {

    public String getMessage(String name) {
        return String.format("Goodbye %s!", name);
    }

}
