import React from "react";
import { SocialIcon } from "react-social-icons"; 

import logo from "../../images/icon.png";

const Footer = () => (
  <div className="w-full flex md:justify-center justify-between items-center flex-col p-4 gradient-bg-footer">
    <div className="w-full flex sm:flex-row flex-col justify-between items-center my-4">
      <div className="flex flex-[0.5] justify-center items-center">
        <img src={logo} alt="logo" className="w-32" />
      </div>
      <div className="flex flex-1 justify-evenly items-center flex-wrap sm:mt-0 mt-5 w-full">
      <div class="socials-logo">
        <div className="flex space-x-4 my-5">
          <a
            className="text-white text-l font-extrabold"
            class="hire-me-btn"
            href="mailto:paulinebanye@gmail.com"
            target="blank"
            class="hire-me-content"
          >
            Get in touch! <i class="fas fa-arrow-right font-extrabold"></i>
          </a>
            <span className="flex space-x-4  my-5">
              <SocialIcon bgColor="grey" url="https://github.com/pauline-banye" />
              <SocialIcon url="https://twitter.com/PauLynn_Bee" />
              <SocialIcon url="https://www.linkedin.com/in/paulinebanye/" />
            </span>
          </div>
        </div>
      </div>
    </div>
    <div className="sm:w-[90%] w-full h-[0.25px] bg-gray-400 mt-5 " />

    <div className="sm:w-[90%] w-full flex justify-between items-center mt-3">
      <p className="text-white text-left text-xs">@lynntoken2022</p>
      <p className="text-white text-right text-xs">All rights reserved</p>
    </div>
  </div>
);

export default Footer;
