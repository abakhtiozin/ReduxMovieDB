import hudson.model.Node.Mode
import hudson.slaves.*
import jenkins.model.Jenkins

DumbSlave dumb = new DumbSlave(
    "nmacnode",  // Agent name, usually matches the host computer's machine name
    "",           // Agent description
    "/tmp",                  // Workspace on the agent's computer
    "1",             // Number of executors
    Mode.EXCLUSIVE,             // "Usage" field, EXCLUSIVE is "only tied to node", NORMAL is "any"
    "mac",                         // Labels
    new JNLPLauncher(),         // Launch strategy, JNLP is the Java Web Start setting services use
    RetentionStrategy.INSTANCE // Is the "Availability" field and INSTANCE means "Always"
)
Jenkins.instance.addNode(dumb)
println "Agent created"