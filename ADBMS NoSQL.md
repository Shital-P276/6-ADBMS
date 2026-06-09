 
#### Advantages
- Fast 
- Easy to Scale
- huge amount of data
- schema less / dynamic schema
- Opensource and free
- high availability as cluster of servers
- Simple APIs
- Distributed - hence  Autoscaling and failover capabilities 


| Type     | Graph                                                                                                                                                                                                        | Key-Value                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | Column                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | Document                                                                                                                                                                                                                                              |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Example  | [[#Neo4j]],<br>neptune                                                                                                                                                                                       | redis, ri                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | HBase,Bigtable,[[#Cassandra]]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | MongoDB, CouchDB                                                                                                                                                                                                                                      |
| Features | - Nodes & Relationships<br>- Relationships have directional significance<br>- Query on graph = traversing a graph                                                                                           - Key : identifier associated with values<br>- Support separate namespaces<br>- Keys must be unique in a namespace<br>- Values can be anything(object)<br>- namespace is collection of key value pairs<br>- [[#Partitioning]] : split workload evenly using partition key (partition key = key)<br>- **architecture** (cluster( loosely / tightly coupled) (master slave cluster / masterless clusters) \| Rings(closed loop node connected to one previous node & one next node ) \| replication)<br><br><br>- store data as maps \| HashMap \| associative arrays >-  | - most complex NoSQL<br>- cols store a name and value <br>- a set of cols make a row ( rows can have same or different cols )<br>- cols can be grouped into column families like firstname & lastname<br><br>- **keyspace** (top level \| is similar to schema in RDBMS)<br>-**rowkey** (uniquely identifies rows \| also used to partition and order data \| similar to primary key in RDBMS)<br>-**columns** (stores a single value varying in length )<br>-**column family** ( Group of related columns \| similar to table in RDBMS \| stored in keyspace)<br><br>- cluster (set of servers working together)<br>- [[#Partitioning]]<br>- commit log <br>- bloom filter (tests whether or not an element is member of set \| reduce read operations \| sometimes wrong ) <br>- replication count ( decides where & how replicas are stored \| first replica placed using hash & additional replicas based on node position ) <br>- consistency level(consistency between the copies of data on all replicas \| decides how many replicas must agree)<br>- [[#Processes and Protocols]] | -semistructured entities : JSON BSON XML<br>- no fixed schema<br>- Queried using provided APIs or query langs <br>- documents are grouped into collections<br>(within a collection docs must have a  unique ID)<br>- max size of single doc: 16MB<br> |
| Adv      | - Faster & efficient querying where paths through graphs are involved<br>- Flexibility(Schema changes with the application & needs )<br>- Agility ( well suited for current agile test-driven developments ) | - **simplicity** <br>- **speed** (high throughput)<br>- **scalability** (**Master-Slave replication** (**ADV**: only communicate with master i.e. no need to coordinate with others \| **DISADV**: single point of failure - master )<br>OR / **masterless replication** (no server has master copy of  updated data \| no single server can copy its data to all other servers \| neighbors work in groups ))<br>- high flexiblity <br>- easy updates and cha                                                                                                       | - high performance on aggregation queries like SUM, COUNT,AVG<br>- big data <br>- real time analytics<br><br>Cassandra Advantages: <br>- Elastic Scalabilty<br>- Always On Architecture: NO Single Point of Failure<br>- Fast linear scale performance : increase in nodes = increase in throughput <br>- Flexible data storage (structured / semi-structured / unstructured)<br>- easy data distribution<br>- Transaction support (ACID)<br>- fast writes                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | - flexiblity <br>- no schema defn(dynamic schema)<br><br><br>MongoDB Adv:<br>- fast for semi-structured and complex relationships<br>- Integrations with other software and languages<br>- Not affected by SQL injection                              |
| Disadv   | - Lack of high performance concurrency<br>- Lack of standard Querying languages<br>- Lack of parallelism                                                                                                     | - no complex queries<br>- limited search by value <br>- difficult analytics<br>- data duplication <br>- no s                                                                                                                                                                                                                                                                                                                                                                                                                                                         |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |                                                                                                                                                                                                                                                       |
|          |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |                                                                                                                                                                                                                                                       |

^1b2718

---
#### Scaling 
- Scale Up - Hardware improvement - vertical scaling
- Scale Out - increased no of servers - horizontal scaling

---
#### Partitioning
- split workload evenly across multiple servers using partition key 
- logical subset of the data
##### Vertical partitioning
- Split data by columns/attributes
- Different fields stored on different servers
- Requires joins/aggregation across partitions
##### Horizontal Partitioning (Sharding)
- Split data by rows/records
- Different records stored on different servers
- Requires shard key selection (Shard key : A shard key is one or more keys or fields that exist in all documents in a collection that is used to separate documents. - Can be a Unique doc id , date , category, etc)
###### Can be partitioned by the following types 
- Range Partitioning 
- Hash Partitioning 
- List Partitioning
- composite of the above

---
#### ACID vs BASE 
**ACID :** atomicity consistency integrity durability
**BASE :** Basically Available Soft State  Eventually Consistent
- **Basically available** : even if partial failure the  remaining system  works possible by maintaining multiple copies of same data across multiple servers 
- **Soft State** : Data maybe overwritten by more recent data 
- **Eventually consistent** : DB can be in an inconsistent state for a while but will return to consistency after a while as multiple copies will become consistent
	- **Casual Consistency** : reflects in the order of operations 
	- **read your writes consistency** : once a record updated - all reads of that record will receive the latest value  and never an inconsistent value 
	- **Session Consistency** : is like read-your-write consistency but only for a session - DB remembers all writes of that session
	- **monotonic read** : once you issue a query and see a result you will never see an earlier version of the same result
	- **monotonic write** : ensures that multiple update commands are executed in the order they've been issued

---
#### CAP Theorem
- **Consistency** : Every read gets the most recent write (all nodes on same data)
- **Availability** : every request gets a non-error response w/o guarantee of it being the most recent
- **Partition tolerance** : the system continues to operate despite network issues or breakages

- P is not optional as networks fail so choices remain between CP and AP
- **CP** : prioritize the truth over staying online - network error the DB shuts down or refuses requests - HBase, MongoDB, Bigtable
- **AP** : prioritize staying online - users can read and write but might be outdated versions of data which will be consistent eventually - Cassandra , CouchDB, DynamoDB
- **CA** : only in ideal situations or a single machine 


---
#### Processes and Protocols :
###### 1) Replication 
###### 2) Anti Entropy
- detecting and fixing the differences between the replicas keeping the data consistent and minimizing data transfer
- sending full replicas is inefficient for comparisons - most data is the same SO systems exchange hash values
- Merkle tree method
	- leaf : hash of small data block 
	- intermediate nodes : hash of child nodes
	- root node : hash of entire dataset
- comparison : 
	- compare root level hash : if same replica is identical if different compare lower branches (continue until leaf node reached)
	- only exchange the leaf node block 


###### 3) Gossip Protocol 
- keeping all nodes updated about each other requires large number of messages when the number of nodes increases
- instead of full communication systems use gossip protocol 
- each node shares : 1. its own information | 2. information received from other nodes
- updates gradually  spread across the whole cluster like rumors

###### 4) Hinted handoff
- used to handle write operations when a node is down
- working:
	- the write request is redirected to another online node 
	- node temporarily stores the write request + hint (info about intended node)
	- periodically checks if intended node is online
	- once available it is forwarded to intended node 


---


#### Cassandra 
- Cassandra Advantages: 
	- Elastic Scalability
	- Always On Architecture: NO Single Point of Failure
	- Fast linear scale performance : increase in nodes = increase in throughput 
	- Flexible data storage (structured / semi-structured / unstructured)
	- easy data distribution
	- Transaction support (ACID)
	- fast writes
- peer to peer distributed system
- Architecture
	- Components
		- Node : stores data
		- Data Center : collection of related nodes
		- Cluster : contains one or more data centers
		
	- Storage Engine
		- commit log
		- Mem-Table : memory resident data structure | after commit log data will be written to Mem-Table | can be multiple for single-column-family 
		- SSTable : disk file to which the data is flushed from the mem-table when its contents reach a threshold value.
			- Bloom Filters : quick algorithms to check whether or not  an element is a member of a set
		
	- Operations
		- Read operation :
			- A coordinator can send 3 types of read requests to a replica 
			1) Direct request : read req sent to one of the replicas 
			2) Digest Request : contact to replicas mentioned in consistency level (level 2 = 2 replicas need to acknowledge)
			3) Read repair request : if data not consistent across the node then this request is initiated and most recent data is available across the nodes 
		- Write Operation: 
			1) Dump to commit log and save it 
			2) insert data into table in Mem-Table until its full
			3) if Mem-Table reaches its threshold then data is flushed to SSTable
			
	- Replication
		- one or more nodes act as replicas 
		- if some nodes have out of date values most recent value is returned to client and a read repair request is called in the background to update nodes to latest data
		- Cassandra uses gossip protocol in the background to communicate & detect faulty nodes
		- Strategies : ( each data replicated at N nodes | N being the replication factor configured per instance) 
			1) Simple Strategy :
				- allows a single integer Replication Factor (RF)
				- RF determines the no. of nodes that should contain a copy of each row
				- treats all nodes identically
			2) Network Topology Strategy:
				- allows a RF for each datacenter in cluster  
				- Easier to add in new physical or virtual datacenters to the cluster
- Applications
	Real-time big data applications handle large volumes of fast-changing and unstructured data, enabling instant processing, storage, and analysis. They are widely used in streaming services, social media, e-commerce, IoT, online gaming, SaaS platforms, and other write-intensive systems.
	
- CQL : Cassandra query Language 


---

#### Neo4j
- ACID Compliant Graph DB 
- Highly scalable and Schema-free(flexible schema)
- Advantages:
	- flexible schema
	- ACIP property compliant
	- Scalability(highly scalable)
	- High availability
	- Fast execution and retrieval 
	- reliability 
	- Cypher Query Language
	- built in Web applications 
	- follows property graph model
	  
- General Features 
	- supports Unique constraints
	- native graph storage
	- export of query to JSON and XLS
	- REST APIs
	- JAVA APIs : 1) Cypher API 2) Native Java API
	  
- Architecture
	- Node
	- properties : key value pairs describing nodes and relationships
	- relationships : connects 2 nodes | can have properties  
	- labels : associate a common name to a set of nodes and relationships
	- data browser 
	- Cypher Query Language
	- 