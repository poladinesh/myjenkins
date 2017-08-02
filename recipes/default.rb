#
# Cookbook:: myjenkins
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#include_recipe 'myjenkins::repo-update'
#include_recipe 'apt::default'

apt_repository 'jenkins' do
  uri 'http://pkg.jenkins.io/debian-stable'
  #components ['stable']
  distribution 'binary/'
  key 'https://pkg.jenkins.io/debian/jenkins-ci.org.key'
  notifies :run, 'execute[apt-get update]', :immediately
end

#sudo apt-get update
execute 'apt-get update' do
  action :nothing
end

execute 'adding java repo' do
  command 'add-apt-repository ppa:openjdk-r/ppa'
  notifies :run, 'execute[apt-get update]', :immediately
end

package 'openjdk-8-jdk'
#sudo apt-get install jenkins
package 'jenkins'

service 'jenkins' do
  action [:start, :enable]
end
=begin
Resource: https://wiki.jenkins.io/display/JENKINS/Installing+Jenkins+on+Ubuntu
#wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
remote_file '/tmp/jenkins-ci.org.key' do
  source 'https://pkg.jenkins.io/debian/jenkins-ci.org.key'
  notifies :run, 'execute[add key]', :immediately
  end

execute 'add key' do
  command 'apt-key add /tmp/jenkins-ci.org.key'
  action :nothing
  #not_if File.exist?('/tmp/jenkins-ci.org.key')
end

#sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
file '/etc/apt/sources.list.d/jenkins.list' do
  content 'deb http://pkg.jenkins.io/debian-stable binary/'
  notifies :run, 'execute[apt-get update]', :immediately
end

#installing jre and jdk as they are pre-reqs for jenkins
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install openjdk-8-jdk
sudo update-alternatives --config javac ----> select the one with java8
sudo update-alternatives --config java ----> select the one with java8

=end
